# frozen_string_literal: true

require "test_helper"
require "support/hugo_helpers"

# Marketing-copy voice guard.
#
# The site's hero blames devshops ("Your dev shop stopped delivering") while the
# copy below it used the same commodity-agency language as the devshops we
# compete against - one sentence was near-identical to a competitor's. See
# docs/projects/2510-seo-content-strategy/20-29-strategy/20.09-content-plan-revision-aug-2026.md §11.
#
# This is a ratchet, same idea as data/course_banned_strings.yaml but for the
# marketing surfaces: once a phrase is removed it may never come back. The
# blurbs are duplicated 3-4x across config, content frontmatter and two
# templates with no data binding, so a hand-fix silently leaves stale copies -
# this test is what makes the lockstep edit verifiable.
#
# Banned set is the unambiguous subset of
# docs/90-99-content-strategy/strategy-analysis/90.11-voice-guide.md §3.
# Context-dependent bans ("transform", "discover", "comprehensive") are
# deliberately excluded: they need human judgement and would make this gate
# noisy. Test the shape, not the config.
class MarketingCopyTest < Minitest::Test
  REPO_ROOT = File.expand_path("../..", __dir__)

  # Surfaces a prospect actually reads before deciding. content/blog/** is
  # excluded FROM THIS PASS (540+ imported posts, audited separately per the
  # dev.to ICP gate) - but it is NOT unguarded: the rendered pass below covers
  # blog/**/*.html for the same banned phrases, and the fabrication ratchet at
  # the end covers blog SOURCE for invented-client-work shapes. Do not read this
  # exclusion as "the blog has no gate".
  #
  # content/clients/** is a KNOWN remaining offender - "to the next level"
  # in two case-study excerpts - deferred, not covered here. Add it when that
  # work is scheduled rather than pretending this gate already covers it.
  SURFACES = [
    "config/_default/hugo.toml",
    "content/_index.md",
    "content/pages/**/*.md",
    "content/services/**/*.md",
    "content/use-cases/**/*.md",
    "layouts/next/**/*.html", # the v2 rail is template-authored marketing copy on root layouts
    # ...and its CONTENT side. Without this the pilots' copy had no source-side
    # cover at all: a planted "world-class" in a pilot stub passed the whole
    # suite on 2026-08-22 (docs/20-29-testing-qa/20.11).
    "content/next/**/*.md",
    "themes/beaver/layouts/home.html",
    "themes/beaver/layouts/page/*.html",
    # Blog CHROME (list hero, section furniture) is a marketing surface even
    # though blog POST content is excluded - the stale "17 years" tenure lived
    # in blog/list.html for months because this glob was missing (2026-08-17).
    "themes/beaver/layouts/blog/*.html"
  ].freeze

  BANNED = {
    "seamless" => "voice guide §3 banned adjective - say what actually plugs into what",
    "world-class" => "voice guide §3 banned adjective - unfalsifiable self-praise",
    "cutting-edge" => "voice guide §3 banned adjective - use 'new' or name the thing",
    "best-in-class" => "voice guide §3 banned adjective",
    "state-of-the-art" => "voice guide §3 banned adjective",
    "top-caliber" => "commodity-agency filler - describe the actual screen",
    "next level" => "commodity-agency filler - name the concrete outcome",
    "positive outcomes" => "commodity-agency filler - say which outcome",
    "eliminate roadblocks" => "commodity-agency filler - name the roadblock",
    "trusted technology partner" => "commodity-agency filler - trust is shown, not claimed",
    "supercharge" => "voice guide §3 banned adjective",
    "revolutionize" => "voice guide §3 banned adjective",
    "game-changer" => "voice guide §3 banned phrase",
    "synergy" => "voice guide §3 banned adjective",
    "holistic" => "voice guide §3 banned adjective",
    "empower" => "voice guide §3 banned verb - 'your team can now ...'",
    # Factual ratchet, not a voice rule. The site published "4.8/5 by 32
    # clients" / "Based on 32 client reviews" / reviewCount:32 while the live
    # Clutch profile showed 9 (verified 2026-08-14). The count had no source
    # anywhere in the repo. It survived a first fix pass because it was worded
    # three different ways in three files - hence all three spellings here.
    "32 client" => "false review count - Clutch shows 9, link the profile instead",
    "by 32" => "false review count - Clutch shows 9, link the profile instead",
    "thirty-two clients" => "false review count - Clutch shows 9, link the profile instead",
    # Same class: a wrong number that lived in many spellings across many files.
    # JetThoughts was founded 2008-09-01; the site carried 2011 for years, which
    # also made every derived "N+ years" claim three short. Derive tenure from
    # site.Params.foundingYear - never hardcode the year (corrected 2026-08-14).
    "since 2011" => "stale tenure - founded 2008-09-01; derive from site.Params.foundingYear",
    "founded in 2011" => "stale tenure - founded 2008-09-01",
    # Same class again (found live 2026-08-17 in blog/list.html AND a blog
    # post): a hardcoded tenure goes stale every January. Company tenure is
    # 18 in 2026 and rising - any hardcoded "17 years" spelling is either
    # already wrong or about to be. Derive or say "since 2008".
    "seventeen years" => "stale tenure - derive from site.Params.foundingYear or say 'since 2008'",
    "17 years of" => "stale tenure - derive from site.Params.foundingYear or say 'since 2008'"
    # Deliberately NOT banning "15+ years": it catches staff-experience claims
    # ("our fractional CTOs average 15+ years of industry experience") that are
    # independent of when the company was founded. Only company-tenure
    # spellings belong here. A ban that cannot tell the two apart is noise.
  }.freeze

  # Surfaces that render the rating block but are not marketing prose pages.
  EXTRA_SURFACES = ["themes/beaver/layouts/partials/page/testimonials.html"].freeze

  def test_marketing_surfaces_carry_no_banned_phrases
    violations = marketing_files.flat_map { |path| banned_phrases_in(path) }

    assert_empty violations.sort,
      "Banned marketing phrases found. These read as the commodity-devshop " \
      "language the homepage hero blames - replace the promise with the " \
      "mechanic (voice guide §3):\n  " + violations.sort.join("\n  ")
  end

  def test_every_declared_surface_matches_at_least_one_file
    unmatched = (SURFACES + EXTRA_SURFACES).reject { |pattern| Dir.glob(File.join(REPO_ROOT, pattern)).any? }

    assert_empty unmatched,
      "Surface patterns match nothing on disk - a path moved and this guard " \
      "went silently blind: #{unmatched.join(", ")}"
  end

  # ---- Second pass: the SAME banned list, over BUILT HTML (20.10 §3b P0-4) ----
  #
  # The pass above reads source, so three whole classes of defect are invisible
  # to it - all three shipped on 2026-08-14: a false figure in a partial no glob
  # covered, a banned phrase wrapped across two template lines, and markup that
  # only exists after compose. Rendering resolves partials, flattens wraps, and
  # includes every page whether or not someone remembered a glob.
  #
  # Scope is blog + course + services: the pages a prospect reads. dev.to
  # imports are excluded - they carry third-party stats belonging to their
  # original authors and are governed by the separate dev.to ICP gate, not this
  # ratchet. The excluded set is DERIVED from `source: dev_to` frontmatter, so
  # it tracks the imports instead of rotting as a hand-typed list.
  RENDERED_GLOBS = %w[blog/**/*.html course/**/*.html services/**/*.html next/**/*.html].freeze

  # Paginated list views (/blog/page/7/, /blog/tags/startup/page/4/) only
  # re-print excerpts from posts this pass already counts, so every hit on them
  # is a double-count of a defect that has a real home. They also made the
  # baseline depend on the build: bin/hugo-build emits no tag pagination, so the
  # same tree scored 48 there and 60 under the suite's own build. Dropping them
  # gives 40 in both. Page 1 (/blog/) is NOT paginated and stays covered - the
  # stale "17 years" tenure lived in exactly that chrome.
  PAGINATED_VIEW = %r{/page/\d+/}

  # RATCHET, not a cleanup gate: fails only when the count goes UP.
  #
  # 40 -> 14 on 2026-08-20. The pass was introduced at 40, and 25 of those were
  # ONE defect syndicated: two content/clients excerpts ("to the next level")
  # pulled onto all 12 services pages by a partial no source glob covers, plus a
  # testimonial saying "seamlessly" (removed with the fabricated testimonials the
  # same day). Rewriting two excerpt lines cleared 26 hits across the conversion
  # pages - which is the whole argument for reading RENDERED output: source
  # matching sees two files, the reader sees twelve.
  #
  # The remaining hits live in individual post bodies. Tighten this number every
  # time a batch is cleared; a ratchet left slack lets the win regress silently
  # - which is not hypothetical: this sat at 14 against an actual 11, and those
  # three spare hits swallowed a planted "world-class" whole (2026-08-22,
  # docs/20-29-testing-qa/20.11). Set it to the measured count, then prove the
  # ratchet is exact by dropping it one lower and watching it fail.
  RENDERED_BASELINE = 11

  def test_rendered_pages_do_not_regress_on_banned_phrases
    violations = rendered_files.flat_map { |path| rendered_hits(path) }.sort

    assert_operator violations.size, :<=, RENDERED_BASELINE,
      "Banned phrases in BUILT HTML went up (baseline #{RENDERED_BASELINE}, " \
      "now #{violations.size}). Rendered output is what a prospect actually " \
      "reads - fix the source that produced these:\n  " + violations.join("\n  ")
  end


  # ---------------------------------------------------------------------------
  # Fabricated-claim ratchet over blog SOURCE.
  #
  # BANNED above is a phrase guard - it catches stale tenure and commodity-agency
  # voice. It cannot catch the class claims-canon.md calls "invented client
  # work", because a fabricated case study is built from ordinary words. What it
  # does have is a STRUCTURE, and structure is greppable.
  #
  # Why this exists: three successive hand-sweeps on 2026-08-22 each found
  # carriers the previous one missed, because each keyed on the wrong surface. A
  # "N clients" regex missed everything phrased as a case study; a
  # case-study-heading sweep missed everything phrased as "in our experience";
  # both missed frontmatter. That is claims-canon.md's own finding ("manual
  # sweeps under-count badly") reproducing itself inside one session. A ratchet
  # does not need to recognise a fabrication - it only has to notice the count
  # going up.
  #
  # Markers are SHAPE, not judgement:
  #
  # - a case-study heading. Real client work belongs in content/clients with a
  #   named client behind it; a "Case Study" heading inside a technical post has
  #   been an invented company every time it has been checked.
  # - "in our experience" / "the pattern we see" - the recurrence-generalisation
  #   hatch, which is what a fabricated specific collapses into when someone
  #   drops the number but keeps the authority.
  # - "(figures unverified)" - a number tagged instead of removed. The tag is the
  #   part a reader skips; the number still does the persuading.
  #
  # dev.to imports are excluded on the same derivation the rendered pass uses:
  # their stats belong to their original authors. That is a TEST-scoping call,
  # NOT editorial absolution - those posts are still published on our domain and
  # are governed by the separate dev.to ICP gate.
  # Headings cannot wrap - Markdown ends them at the newline - so these match
  # line by line and report a line number, which is what you want when fixing.
  FABRICATION_HEADING_MARKERS = {
    /^\#{2,4}\s.*\bcase stud/i => "case-study heading - check there is a real, nameable subject behind it"
  }.freeze

  # Prose DOES wrap, and a line-by-line scan never shows the regex a phrase that
  # straddles a newline: `/\bin our experience\b/` returns false against
  # "in our\nexperience". So these match the whitespace-collapsed document, the
  # same reason the rendered pass above collapses before matching. The cost is
  # losing the line number; the alternative is a gate with a hole in it.
  FABRICATION_PHRASE_MARKERS = {
    /\bin our experience\b/i => "recurrence-generalisation - unfalsifiable authority claim",
    /\bthe pattern (we see|across the)/i => "recurrence-generalisation - the de-fabrication escape hatch",
    /\(figures unverified\)/i => "a tagged number is still a published number"
  }.freeze

  # A case-study heading is a SUSPICION, not a verdict - the shape is identical
  # whether the subject is invented or real. `async-remote-xp-practices` writes
  # up this repository's own CSS migration, which is as verifiable as a case
  # study gets: the commits are in this git history.
  #
  # Adding a line here is a claim that someone checked. The test is whether the
  # write-up names a subject a reader could go and verify - this repo, a named
  # client, a public postmortem. "A medium-sized content platform" is not a
  # subject, and that is the whole difference.
  VERIFIED_CASE_STUDIES = {
    "content/blog/async-remote-xp-practices/index.md" => ["jt_site CSS Migration"]
  }.freeze

  # RATCHET, not a cleanup gate: fails only when the count goes UP.
  #
  # Measured after the 2026-08-22 purge, which cleared nine posts including the
  # two largest carriers by impressions - langgraph (40,025) and propshaft
  # (6,194). Survivors are lower-traffic posts not yet swept.
  #
  # Tighten this every time a batch is cleared. A ratchet left slack lets the win
  # regress silently - the rendered baseline above sat at 14 against an actual 11
  # and those three spare hits swallowed a planted phrase whole. Set it to the
  # measured count, then prove it is exact by dropping it one lower and watching
  # it fail.
  #
  # 9 survivors, all in the same three posts, all parked by an explicit decision
  # rather than by neglect. Every other carrier has been cleared. Run the test to
  # list them - it prints file:line for every one.
  FABRICATION_BASELINE = 9

  def test_blog_does_not_regress_on_fabricated_claim_markers
    hits = fabrication_hits.sort

    assert_operator hits.size, :<=, FABRICATION_BASELINE,
      "Fabricated-claim markers in blog source went up (baseline " \
      "#{FABRICATION_BASELINE}, now #{hits.size}). These shapes carry invented " \
      "client work - see .okf/content/claims-canon.md:\n  " + hits.join("\n  ")
  end

  # ---------------------------------------------------------------------------
  # CHECKABILITY ratchet.
  #
  # The gate above counts invented shapes. Neither it nor any regex can tell you
  # whether a claim is TRUE - a wrong mechanism is a well-formed sentence using
  # the right vocabulary (two candidate markers for it were measured and
  # rejected at 10 and 185 mostly-legitimate hits, 2026-08-22).
  #
  # What IS mechanical is whether a claim can be checked AT ALL. A long
  # technical post that cites nothing external is unverifiable by construction:
  # the reader cannot check it, and - the part that actually bites - neither
  # could whoever wrote it. Uncheckable is where false hides.
  #
  # Found on 2026-08-22: 39 of 93 substantial non-dev.to posts cited nothing (38
  # after the Laravel fix below),
  # including a 7,794-word APM comparison that links to no APM tool's docs and a
  # 20,226-impression Laravel migration guide whose target version had been out
  # of security support for five months. Nobody could have noticed that from
  # inside the post, because there was nothing to notice it against.
  #
  # Corrected 2026-08-24: the count was 34, not 38. The extractor below read
  # split(/^---/)[2], which truncates the body at the first in-body "---"
  # horizontal rule - and these posts keep their "Resources and Further
  # Reading" links AFTER one. 6 posts were phantoms (cited, but past the cut;
  # solid-cache among them, which 20.09 §13i then put FIRST in the repair
  # queue), and 2 genuinely-uncited posts were invisible because the truncated
  # word count fell under the floor. The instrument beat the grep that day and
  # was wrong anyway - reproduce the accusation by hand before believing it.
  #
  # 400 words is the floor: below it a post is a note, and demanding citations
  # of a note is the noise this file's header warns about. Internal jetthoughts
  # links do not count - the question is whether the claim can be checked
  # against something we do not control.
  CITATION_WORD_FLOOR = 400

  # RATCHET: fails when the count goes UP. Tighten it whenever a batch is cited.
  # 34 measured 2026-08-24 after the truncation fix (was 38, of which 6 were
  # phantoms and 2 real carriers were invisible).
  # → 33 after citing propshaft (9 refs, 2026-08-24).
  # → 0 after batch-citing 32 remaining posts (2026-08-24). Every substantial
  #   blog post now carries a ## Sources section with external references.
  UNCITED_BASELINE = 0

  def test_substantial_blog_posts_do_not_regress_on_uncitedness
    uncited = uncited_posts.sort

    assert_operator uncited.size, :<=, UNCITED_BASELINE,
      "Substantial blog posts with ZERO external citations went up (baseline " \
      "#{UNCITED_BASELINE}, now #{uncited.size}). A claim nobody can check is " \
      "where a false one hides - cite the primary source (blog-pipeline.md " \
      "STEP 4f routes the tool):\n  " + uncited.join("\n  ")
  end

  private

  def rendered_root
    @rendered_root ||= Hugo.instance.precompile.destination_path
  end

  def rendered_files
    files = RENDERED_GLOBS.flat_map { |g| Dir.glob(File.join(rendered_root, g)) }

    assert files.any?, "No built HTML under #{rendered_root} - this gate would " \
      "pass by finding nothing. Run bin/hugo-build."

    files.reject { |path| path.match?(PAGINATED_VIEW) || devto_import?(path) }
  end

  def devto_import?(path)
    relative = path.sub("#{rendered_root}/", "")
    return false unless relative.start_with?("blog/")

    devto_slugs.include?(relative.split("/")[1])
  end

  # Frontmatter lives in the first few lines; bound the read so 689 posts stay cheap.
  def devto_slugs
    @devto_slugs ||= Dir.glob(File.join(REPO_ROOT, "content/blog/*/index.md")).filter_map { |post|
      File.basename(File.dirname(post)) if File.foreach(post).first(60).any? { |l| l.start_with?("source: dev_to") }
    }.to_set
  end

  # No line-by-line pass here: collapsing the whole document is what makes
  # wrapped prose visible in the first place, and in generated output a page
  # path points somewhere more useful than a line number.
  #
  # The noise removal differs from source's `scrub` on purpose. Slugs and asset
  # names live in attributes, so tag-stripping already takes them out and only
  # <script>/<style> bodies survive it. Dropping those two blocks does the job
  # of source's three token regexes, finds the identical 40 hits, and costs
  # 0.9s instead of 6.4s over the same 1,178 pages.
  def rendered_hits(path)
    relative = path.sub("#{rendered_root}/", "")
    haystack = File.read(path, encoding: "bom|utf-8")
      .gsub(%r{<(script|style)\b.*?</\1>}mi, " ")
      .gsub(/<[^>]*>/, " ")
      .downcase.gsub(/\s+/, " ")

    BANNED.filter_map do |phrase, reason|
      "#{relative} #{phrase.inspect} - #{reason}" if haystack.include?(phrase)
    end
  end

  def marketing_files
    (SURFACES + EXTRA_SURFACES)
      .flat_map { |pattern| Dir.glob(File.join(REPO_ROOT, pattern)) }
      .uniq
      .select { |p| File.file?(p) }
  end

  # Machine identifiers, not reader-facing prose. A menu `identifier`, a
  # frontmatter `slug`/`url`, or an alias legitimately keeps a banned word
  # because renaming it would mean a redirect bridge, which the repo forbids.
  IDENTIFIER_LINE = /^\s*(identifier\s*=|slug:|url:|pageRef\s*=|aliases:|-\s*\/)/

  def banned_phrases_in(path)
    per_line_hits(path) + wrapped_hits(path)
  end

  def per_line_hits(path)
    relative = path.sub("#{REPO_ROOT}/", "")

    File.readlines(path, encoding: "bom|utf-8").each_with_index.flat_map do |line, index|
      next [] if line.match?(IDENTIFIER_LINE)

      haystack = scrub(line).downcase

      BANNED.filter_map do |phrase, reason|
        "#{relative}:#{index + 1} #{phrase.inspect} - #{reason}" if haystack.include?(phrase)
      end
    end
  end

  # Templates wrap prose across lines, so a banned phrase can straddle a line
  # break and be invisible to line-by-line matching. careers.html rendered
  # "Looking for a Team to Take You to the Next\nLevel?" - the live H1 said
  # "next level" and this gate reported clean for a full day. Collapse
  # whitespace across the whole file and check again; no line number is
  # available for these, so report the file.
  def wrapped_hits(path)
    relative = path.sub("#{REPO_ROOT}/", "")

    body = File.read(path, encoding: "bom|utf-8")
      .lines
      .reject { |line| line.match?(IDENTIFIER_LINE) }
      .join(" ")
    haystack = scrub(body).downcase.gsub(/\s+/, " ")

    BANNED.filter_map do |phrase, reason|
      next unless haystack.include?(phrase)
      next if per_line_hits(path).any? { |hit| hit.include?(phrase.inspect) }

      "#{relative} (wrapped across lines) #{phrase.inspect} - #{reason}"
    end
  end

  # Slugs, URLs and asset names legitimately keep banned words -
  # /use-cases/empower-existing-engineering-team/, the SVG
  # theme/world-class-training, and cover_image: empower-...jpg are
  # identifiers, not prose. Renaming them would mean redirect bridges or asset
  # churn, which buys nothing. Drop both shapes before matching: any token
  # containing a slash, and any token ending in an asset extension.
  ASSET_TOKEN = /\S+\.(?:jpe?g|png|svg|webp|gif|ico)\b/i
  PATH_TOKEN = %r{/?[\w.-]+(?:/[\w.-]+)+/?}

  # Order matters. Tags must go FIRST: a word glued to a closing tag
  # ("Level?</span") contains a slash, and stripping slash-tokens wholesale
  # deleted the word with it - which is how "Take You to the Next Level" hid
  # from this gate while sitting in the careers <h1>.
  def scrub(line)
    line
      .gsub(/\{\{.*?\}\}/, " ")   # Hugo template expressions
      .gsub(/<[^>]*>/, " ")       # HTML tags
      .gsub(%r{\S*://\S*}, " ")   # absolute URLs
      .gsub(PATH_TOKEN, " ")      # slugs and partial names (theme/world-class-training)
      .gsub(ASSET_TOKEN, " ")
  end

  def fabrication_hits
    posts = blog_source_files

    assert posts.any?, "No blog source found - this gate would pass by finding nothing."

    posts.flat_map do |path|
      relative = path.sub("#{REPO_ROOT}/", "")
      body = File.read(path, encoding: "bom|utf-8")

      heading_hits(relative, body) + phrase_hits(relative, body)
    end
  end

  def heading_hits(relative, body)
    verified = VERIFIED_CASE_STUDIES.fetch(relative, [])

    body.lines.each_with_index.flat_map do |line, i|
      next [] if verified.any? { |subject| line.include?(subject) }

      FABRICATION_HEADING_MARKERS.filter_map do |pattern, reason|
        "#{relative}:#{i + 1} - #{reason}" if line.match?(pattern)
      end
    end
  end

  # Collapsed to one line first, so a phrase broken across a wrap still matches.
  # Fenced code is stripped first. A post can legitimately QUOTE bad writing as
  # an exhibit - a diff showing the sentence that was wrong, a log line, a
  # command someone should not run - and scanning inside the fence flags the
  # exhibit as if we were asserting it. Found 2026-08-22 when a post about a
  # corrected claim reproduced the original claim in a ```diff and tripped this
  # ratchet on its own evidence.
  def phrase_hits(relative, body)
    haystack = body.gsub(/^```.*?^```/m, " ").gsub(/\s+/, " ")

    FABRICATION_PHRASE_MARKERS.filter_map do |pattern, reason|
      "#{relative} - #{reason}" if haystack.match?(pattern)
    end
  end

  def uncited_posts
    posts = blog_source_files

    assert posts.any?, "No blog source found - this gate would pass by finding nothing."

    posts.filter_map do |path|
      # Everything after the frontmatter close, NOT just up to the first
      # in-body "---" rule: [2] alone truncates there, which hid citations in
      # "Resources" sections (6 phantom posts) and under-counted words (2 real
      # carriers fell under the floor). Found 2026-08-24.
      body = File.read(path, encoding: "bom|utf-8").split(/^---\s*$/m)[2..].to_a.join("\n")
      next if body.split.size < CITATION_WORD_FLOOR

      external = body.scan(%r{\]\((https?://[^)]+)\)}).flatten
                     .reject { |url| url.include?("jetthoughts.com") }
      path.sub("#{REPO_ROOT}/", "") if external.empty?
    end
  end

  # Frontmatter lives in the first few lines; bound the read so 689 posts stay cheap.
  def blog_source_files
    Dir.glob(File.join(REPO_ROOT, "content/blog/**/*.md")).reject do |path|
      File.foreach(path).first(60).any? { |l| l.start_with?("source: dev_to") }
    end
  end
end
