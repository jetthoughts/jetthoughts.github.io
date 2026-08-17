# frozen_string_literal: true

require "test_helper"

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
  # excluded (540+ imported posts, audited separately per the dev.to ICP gate)
  # and content/clients/** is a KNOWN remaining offender - "to the next level"
  # in two case-study excerpts - deferred, not covered here. Add it when that
  # work is scheduled rather than pretending this gate already covers it.
  SURFACES = [
    "config/_default/hugo.toml",
    "content/_index.md",
    "content/pages/**/*.md",
    "content/services/**/*.md",
    "content/use-cases/**/*.md",
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

  private

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
end
