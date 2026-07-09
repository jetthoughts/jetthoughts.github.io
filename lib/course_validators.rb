# frozen_string_literal: true

# Source-of-truth validators for the Tech for Non-Technical Founders 2026 course.
# Each validator reads course chapters from disk and reports violations.
#
# Hook locations: bin/hugo-build (pre-flight), Rakefile tasks, CI pipeline.
# Usage: CourseValidators.run_all => [Result, ...]
#
# Reference: TASK-TRACKER.md P1 - "Build 4 source-of-truth validators (Kaizen Muda outcome)"

require "yaml"
require "date"
require "set"

class CourseValidators
  COURSE_DIR = "content/course"
  YAML_PATH = "data/course_sequence.yaml"
  ALL_BLOG_DIR = "content/blog"

  Result = Struct.new(:name, :passed, :violations, keyword_init: true) do
    def to_s
      status = passed ? "PASS" : "FAIL"
      "#{status}  #{name}#{violations.any? ? "\n  #{violations.join("\n  ")}" : ""}"
    end
  end

  def self.run_all
    new.run_all
  end

  def run_all
    [
      check_chapter_number_consistency,
      check_title_yaml_match,
      check_internal_links,
      check_table_width,
      check_disclaimer_consistency,
      check_em_dash_in_content,
      check_year_stamp_fabrication
    ]
  end

  private

  # ── Validator 1: Chapter-number consistency ──────────────────────────────
  # Every "Chapter N.X" reference in body/frontmatter/SVG must resolve to an
  # entry in data/course_sequence.yaml.

  def check_chapter_number_consistency
    violations = []
    valid_chapters = build_valid_chapter_set

    course_chapters.each do |path|
      slug = File.basename(File.dirname(path))
      body = File.read(path)

      # Find all "Chapter N.X" patterns in the body (not inside URLs or code blocks)
      body.scan(/Chapter\s+(\d+\.\d+)/) do |match|
        ref = match.first
        unless valid_chapters.include?(ref)
          violations << "#{slug}: references 'Chapter #{ref}' which is not in course_sequence.yaml"
        end
      end

      # Also check "Module N" callout references (e.g., "> **Module 1 · Step 2 of 3**")
      body.scan(/> \*\*Module\s+(\d+)\s/) do |match|
        module_num = match.first
        # Module N should correspond to Chapter N.X
        # Extract the chapter number from the title frontmatter
        fm = parse_frontmatter(path)
        next unless fm["title"]
        title_match = fm["title"].match(/(\d+)\.(\d+)/)
        next unless title_match
        expected_module = title_match[1]
        if module_num != expected_module
          violations << "#{slug}: callout says 'Module #{module_num}' but title '#{fm["title"]}' starts with #{expected_module}"
        end
      end
    end

    # Check SVG files for stale chapter references (recursive for nested course structure)
    Dir["#{COURSE_DIR}/**/*.svg"].each do |svg_path|
      slug = File.basename(File.dirname(svg_path))
      content = File.read(svg_path)

      content.scan(/Chapter\s+(\d+\.\d+)/) do |match|
        ref = match.first
        next if ref == "Chapter 0.0" # Skip any default/placeholder
        unless valid_chapters.include?(ref)
          violations << "#{slug}/#{File.basename(svg_path)}: SVG references 'Chapter #{ref}' which is not in course_sequence.yaml"
        end
      end
    end

    Result.new(name: "chapter-number-consistency", passed: violations.empty?, violations: violations)
  end

  # ── Validator 2: Title-YAML byte-for-byte match ──────────────────────────
  # Frontmatter title / og_title must START WITH the YAML title for that slug.
  # The callout prefix must match the chapter number.

  def check_title_yaml_match
    violations = []
    yaml_map = build_yaml_title_map

    course_chapters.each do |path|
      slug = File.basename(File.dirname(path))
      fm = parse_frontmatter(path)
      yaml_entry = yaml_map[slug]

      # Supplementary chapters (course_chapter: true but not in the linear sequence)
      # are not in the YAML. Skip them for the title-match check - they have their
      # own title scheme outside the X.Y · Foo convention.
      next unless yaml_entry

      yaml_title = yaml_entry["title"]
      fm_title = fm["title"]
      fm_og_title = fm.dig("metatags", "og_title") || fm["og_title"]

      # Check frontmatter title starts with YAML title
      if fm_title && !fm_title.start_with?(yaml_title)
        violations << "#{slug}: frontmatter title '#{fm_title}' does not start with YAML title '#{yaml_title}'"
      end

      # Check og_title starts with YAML title
      if fm_og_title && !fm_og_title.start_with?(yaml_title)
        violations << "#{slug}: og_title '#{fm_og_title}' does not start with YAML title '#{yaml_title}'"
      end

      # Check callout chapter number matches YAML module
      body = File.read(path)
      callout_match = body.match(/> \*\*Module\s+(\d+) · Step (\d+) of (\d+)\*\*/)
      if callout_match
        step_num = callout_match[2]
        total_steps = callout_match[3]

        # YAML module field is like "Chapter 1.1"
        yaml_module = yaml_entry["module"]
        chapter_match = yaml_module.match(/(\d+)\.(\d+)/)
        next unless chapter_match

        yaml_chapter_num = chapter_match[2]
        if step_num != yaml_chapter_num
          violations << "#{slug}: callout says 'Step #{step_num}' but YAML module '#{yaml_module}' has chapter #{yaml_chapter_num}"
        end
      end
    end

    Result.new(name: "title-yaml-match", passed: violations.empty?, violations: violations)
  end

  # ── Validator 3: Internal-link existence ─────────────────────────────────
  # Every /blog/slug/ link in course chapters must resolve to an existing
  # content/blog/slug/index.md.

  def check_internal_links
    violations = []
    course_slugs = build_course_slug_set

    course_chapters.each do |path|
      slug = File.basename(File.dirname(path))
      body = File.read(path)

      # Find INTERNAL /blog/X/ markdown links - i.e., `[text](/blog/X/)` form.
      # External URLs like `[text](https://example.com/blog/X/)` start with `https`
      # so won't match `\(/blog/`. This is the only form we should validate.
      body.scan(%r{\]\(/blog/([^/"')\]\s]+)/\)}) do |match|
        target_slug = match.first
        # If target is a course slug, it should now live under /course/<namespace>/
        next if course_slugs.include?(target_slug)
        target_path = "#{ALL_BLOG_DIR}/#{target_slug}"

        unless Dir.exist?(target_path)
          violations << "#{slug}: links to /blog/#{target_slug}/ but directory content/blog/#{target_slug}/ does not exist"
        end
      end

      # Find INTERNAL /course/<namespace>/<slug>/ markdown links
      body.scan(%r{\]\(/course/([^/"')\]\s]+)/([^/"')\]\s]+)/\)}) do |match|
        namespace, target_slug = match
        target_path = "#{COURSE_DIR}/#{namespace}/#{target_slug}"

        unless Dir.exist?(target_path)
          violations << "#{slug}: links to /course/#{namespace}/#{target_slug}/ but directory #{target_path}/ does not exist"
        end
      end
    end

    Result.new(name: "internal-link-existence", passed: violations.empty?, violations: violations)
  end

  # Helper: set of all course chapter slugs (so we can skip /blog/<course-slug>/
  # links that are intentionally backed by Hugo aliases now)
  def build_course_slug_set
    @course_slug_set ||= begin
      set = Set.new
      course_chapters.each do |path|
        set.add(File.basename(File.dirname(path)))
      end
      set
    end
  end

  # ── Validator 4: Mobile-table width ──────────────────────────────────────
  # Tables with >=5 columns in course_chapter: true posts fail the build.
  # Detected by counting pipe-separated cells in the separator row (|---|).

  def check_table_width
    violations = []

    course_chapters.each do |path|
      slug = File.basename(File.dirname(path))
      body = File.read(path)

      # Find markdown tables by looking for separator rows
      body.scan(/^\|[- :|]+\|$/) do |separator|
        # Count columns by splitting on |
        columns = separator.strip.split("|").reject(&:empty?)
        col_count = columns.length

        if col_count >= 5
          # Find context: the previous line should be the header row
          lines = body.lines
          sep_index = lines.index { |l| l.strip == separator.strip }
          context = if sep_index && sep_index > 0
            lines[sep_index - 1].strip
          else
            "(unknown context)"
          end

          violations << "#{slug}: table with #{col_count} columns (>=5) found in context: \"#{context[0..60]}\""
        end
      end
    end

    Result.new(name: "table-width", passed: violations.empty?, violations: violations)
  end

  # ── Validator 5: Disclaimer consistency (all-or-none) ────────────────────
  # A per-chapter boilerplate disclaimer must appear in EVERY course chapter or
  # NONE. Present in only some = inconsistent artifact (the user flagged a
  # disclaimer living in 2 of 18 chapters on 2026-05-22).

  DISCLAIMER_MARKER = "anonymized names"

  def check_disclaimer_consistency
    chapters = course_chapters
    with = chapters.select { |p| File.read(p).include?(DISCLAIMER_MARKER) }
    violations = []
    if with.any? && with.length < chapters.length
      slugs = with.map { |p| File.basename(File.dirname(p)) }
      violations << "disclaimer ('#{DISCLAIMER_MARKER}') present in #{with.length}/#{chapters.length} chapters (must be all or none): #{slugs.join(", ")}"
    end
    Result.new(name: "disclaimer-consistency", passed: violations.empty?, violations: violations)
  end

  # ── Validator 6: No em-dashes in content ─────────────────────────────────
  # Project rule: use "-" not "—" in all content. Code fences excluded so
  # legitimate code samples don't false-positive.

  def check_em_dash_in_content
    violations = []
    course_chapters.each do |path|
      slug = File.basename(File.dirname(path))
      count = strip_code_fences(File.read(path)).count("—")
      violations << "#{slug}: #{count} em-dash(es) (—) in content - use '-' instead" if count.positive?
    end
    Result.new(name: "no-em-dash", passed: violations.empty?, violations: violations)
  end

  # ── Validator 7: Year-stamp client-cohort fabrication ────────────────────
  # Flags fabricated client-cohort timelines ("founders we joined in 2026",
  # "A 2026 example"). Real dated references (a book's pub date, a CVE year)
  # are NOT matched - only the "clients we X in YEAR" cohort shapes.

  COHORT_YEAR_PATTERNS = [
    /\b(?:founders?|clients?|teams?|rescues?)\s+we\s+(?:joined|ran|rescued|worked with)\s+(?:in\s+)?(?:early |mid |late |January |February |March |April |May |June |July |August |September |October |November |December )?20\d{2}/i,
    /\bA\s+20\d{2}\s+example\b/i,
    /\bwe\s+(?:joined|rescued|ran)\b[^.\n]*\bin\s+(?:early |mid |late |January |February |March |April |May |June |July |August |September |October |November |December )?20\d{2}/i
  ].freeze

  def check_year_stamp_fabrication
    violations = []
    course_chapters.each do |path|
      slug = File.basename(File.dirname(path))
      body = File.read(path)
      COHORT_YEAR_PATTERNS.each do |re|
        body.scan(re) { |_| violations << "#{slug}: fabricated client-cohort year-stamp (matched /#{re.source}/)" }
      end
    end
    Result.new(name: "year-stamp-fabrication", passed: violations.empty?, violations: violations)
  end

  # ── Helpers ──────────────────────────────────────────────────────────────

  def strip_code_fences(text)
    text.gsub(/```.*?```/m, "")
  end

  def course_chapters
    # Recursive glob to handle nested course namespaces
    # (e.g., content/course/tech-for-non-technical-founders-2026/<chapter-slug>/index.md)
    @course_chapters ||= Dir["#{COURSE_DIR}/**/index.md"].select do |f|
      fm = parse_frontmatter(f)
      fm["course_chapter"] == true
    end.sort
  end

  def parse_frontmatter(path)
    content = File.read(path)
    if content =~ /\A---\s*\n(.*?)\n---\s*\n(.*)/m
      YAML.safe_load($1, permitted_classes: [Date, Time]) || {}
    else
      {}
    end
  rescue Psych::SyntaxError => e
    warn "Warning: YAML parse error in #{path}: #{e.message}"
    {}
  end

  def sequence_data
    @sequence_data ||= begin
      data = YAML.load_file(YAML_PATH)
      data["sequence"] || []
    rescue Errno::ENOENT
      warn "Warning: #{YAML_PATH} not found. Run from project root."
      []
    end
  end

  def build_valid_chapter_set
    @valid_chapter_set ||= begin
      set = Set.new
      sequence_data.each do |entry|
        match = entry["module"].match(/(\d+\.\d+)/)
        set.add(match[1]) if match
      end
      set
    end
  end

  def build_yaml_title_map
    @yaml_title_map ||= begin
      map = {}
      sequence_data.each do |entry|
        map[entry["slug"]] = entry
      end
      map
    end
  end
end
