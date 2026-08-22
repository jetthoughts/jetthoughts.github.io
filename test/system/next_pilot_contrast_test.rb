# frozen_string_literal: true

require "application_system_test_case"

# What the screenshot gate cannot see on the register pilots.
#
# 1. BELOW THE FOLD. The capture is viewport-sized: measured on
#    /next/pilots/editorial/fractional-cto/ at 1920x1080 the page is 3822px
#    tall, so 71.7% of it is outside every baseline at every tolerance
#    (20.11 §"What nothing guards"). The comparison table's muted column - the
#    #564 defect - starts at y=1090, ten pixels past the frame, and an
#    injection that recoloured it shipped green.
# 2. CONTRAST AS A NUMBER. A screenshot only knows pixels changed, so an
#    intentional recolour and an AA regression look identical to it. Defect A
#    in the same audit was caught only as a pixel delta; nothing measured the
#    ratio. A 3.33:1 black-on-ruby button shipped this rail and was caught in
#    human review.
#
# Computed styles answer both: they do not care about the viewport, and they
# give a ratio instead of a pixel count. Deliberately NOT per-band
# screenshots - those inherit the tolerance problem (font/SVG-heavy bands need
# their noise floor MEASURED, and the 0.0001 default is unsafe for them,
# .okf/build/test-gates.md) and cost four more baselines per pilot.
class NextPilotContrastTest < ApplicationSystemTestCase
  PILOTS = %w[rescue-room editorial precision].freeze

  # SC 1.4.3: 4.5:1 for body text, 3:1 for large text (>=24px, or >=18.66px
  # bold). SC 1.4.11: 3:1 for the fill of a control against its surround.
  TEXT_MINIMUM = 4.5
  LARGE_TEXT_MINIMUM = 3.0
  NON_TEXT_MINIMUM = 3.0

  def setup
    Capybara.current_driver = :desktop_chrome
    super
  end

  # The whole point of the muted column is that "theirs" reads quieter than
  # "ours". #564 shipped it computing the ink instead - the rule was in source
  # and looked applied; only the computed value showed it losing the cascade.
  # Asserted against the register's own --*-muted token rather than against a
  # literal or a sibling cell: two registers set the "ours" column to the body
  # colour and one sets it to ink, so a sibling comparison passes on a defect
  # in the registers where ink and body differ.
  def test_comparison_table_theirs_column_computes_the_muted_token
    PILOTS.each do |register|
      visit "/next/pilots/#{register}/fractional-cto/"

      assert_selector ".rr-table tbody .rr-td-muted", wait: 5
      got, tokens = page.evaluate_script(<<~JS)
        (function () {
          var probe = document.createElement('span');
          document.body.appendChild(probe);
          var root = getComputedStyle(document.documentElement);
          var tokens = {};
          for (var i = 0; i < root.length; i++) {
            var name = root[i];
            // Surface tokens only: --ed-muted, not --ed-ink-muted (which is
            // the muted tone ON the dark band, a different surface).
            if (!/^--[a-z]+-(muted|ink|body)$/.test(name)) continue;
            probe.style.color = '';
            probe.style.color = root.getPropertyValue(name).trim();
            tokens[name] = getComputedStyle(probe).color;
          }
          probe.remove();
          var cell = document.querySelector('.rr-table tbody .rr-td-muted');
          return [getComputedStyle(cell).color, tokens];
        })()
      JS

      muted = tokens.find { |name, _| name.end_with?("-muted") }
      refute_nil muted, "#{register}: no --*-muted token on :root - this gate would pass by finding nothing"

      assert_equal muted.last, got,
        "#{register}: the \"theirs\" column computes #{got}, not #{muted.first} (#{muted.last}). " \
        "It resolves to #{tokens.select { |_, v| v == got }.keys.join(", ").then { |n| n.empty? ? "no token" : n }} - " \
        "the muted rule lost the cascade and the comparison stopped comparing (#564)"
    end
  end

  # Every visible text run on the WHOLE page, fold or no fold, plus the fill of
  # every control against its surround.
  def test_every_pilot_text_pair_clears_wcag_aa
    PILOTS.each do |register|
      visit "/next/pilots/#{register}/fractional-cto/"

      assert_selector ".rr-hero", wait: 5
      report = page.evaluate_script(contrast_walk)

      assert_operator report["textChecked"], :>, 50,
        "#{register}: only #{report["textChecked"]} text pairs measured - this gate would pass by " \
        "finding nothing (the walk found no visible text, or the page did not render)"
      assert_operator report["fillsChecked"], :>, 0,
        "#{register}: no control fills measured - this gate would pass by finding nothing"

      assert report["failures"].empty?, "#{register}: WCAG AA contrast failures\n" +
        report["failures"].map { |f|
          format("  %.2f:1 (needs %s) %s %s - %s on %s - %s",
            f["ratio"], f["need"], f["kind"], f["selector"], f["fg"], f["bg"], f["sample"])
        }.join("\n")
    end
  end

  private

  # Runs in the page. Composites every translucent layer down to an opaque
  # background before measuring, and reports a pair it cannot resolve (a
  # background image or gradient behind the text) rather than guessing white.
  def contrast_walk
    <<~JS
      (function () {
        var TEXT = #{TEXT_MINIMUM}, LARGE = #{LARGE_TEXT_MINIMUM}, FILL = #{NON_TEXT_MINIMUM};

        function parse(value) {
          var m = /rgba?\\(([^)]+)\\)/.exec(value || '');
          if (!m) return null;
          var p = m[1].split(/[\\s,\\/]+/).filter(Boolean).map(Number);
          return {r: p[0], g: p[1], b: p[2], a: p.length > 3 ? p[3] : 1};
        }
        function channel(v) {
          v = v / 255;
          return v <= 0.03928 ? v / 12.92 : Math.pow((v + 0.055) / 1.055, 2.4);
        }
        function luminance(c) {
          return 0.2126 * channel(c.r) + 0.7152 * channel(c.g) + 0.0722 * channel(c.b);
        }
        function ratio(a, b) {
          var x = luminance(a), y = luminance(b);
          return (Math.max(x, y) + 0.05) / (Math.min(x, y) + 0.05);
        }
        function over(top, bottom) {
          return {
            r: top.r * top.a + bottom.r * (1 - top.a),
            g: top.g * top.a + bottom.g * (1 - top.a),
            b: top.b * top.a + bottom.b * (1 - top.a),
            a: 1
          };
        }
        function label(el) {
          return el.tagName.toLowerCase() + (el.className && el.className.baseVal === undefined
            ? '.' + String(el.className).trim().split(/\\s+/).join('.') : '');
        }
        // Walks up compositing translucent layers. null = an image or gradient
        // sits behind this text and no number here would mean anything.
        function background(el) {
          var layers = [], node = el;
          while (node && node.nodeType === 1) {
            var s = getComputedStyle(node);
            if (s.backgroundImage && s.backgroundImage !== 'none') return null;
            var c = parse(s.backgroundColor);
            if (c && c.a > 0) {
              layers.push(c);
              if (c.a === 1) break;
            }
            node = node.parentElement;
          }
          var base = {r: 255, g: 255, b: 255, a: 1};
          for (var i = layers.length - 1; i >= 0; i--) base = over(layers[i], base);
          return base;
        }
        function visible(el) {
          var s = getComputedStyle(el);
          if (s.display === 'none' || s.visibility === 'hidden' || parseFloat(s.opacity) === 0) return false;
          // .sr-only and friends: clipped to nothing, never seen.
          if (s.clipPath && s.clipPath.indexOf('inset(50%') === 0) return false;
          var r = el.getBoundingClientRect();
          return r.width >= 1 && r.height >= 1;
        }
        function ownText(el) {
          var out = '';
          for (var i = 0; i < el.childNodes.length; i++) {
            if (el.childNodes[i].nodeType === 3) out += el.childNodes[i].nodeValue;
          }
          return out.trim();
        }

        var failures = [], textChecked = 0, fillsChecked = 0;

        Array.prototype.forEach.call(document.body.querySelectorAll('*'), function (el) {
          var text = ownText(el);
          if (!text || !visible(el)) return;
          var s = getComputedStyle(el);
          var fg = parse(s.color), bg = background(el);
          if (!fg) return;
          if (!bg) {
            failures.push({kind: 'text', selector: label(el), fg: s.color, bg: 'image/gradient',
                           ratio: 0, need: 'a resolvable background', sample: text.slice(0, 40)});
            return;
          }
          var size = parseFloat(s.fontSize), weight = parseInt(s.fontWeight, 10) || 400;
          var need = (size >= 24 || (size >= 18.66 && weight >= 700)) ? LARGE : TEXT;
          var got = ratio(over(fg, bg), bg);
          textChecked++;
          if (got + 0.005 < need) {
            failures.push({kind: 'text', selector: label(el), fg: s.color,
                           bg: 'rgb(' + Math.round(bg.r) + ', ' + Math.round(bg.g) + ', ' + Math.round(bg.b) + ')',
                           ratio: got, need: need.toFixed(1) + ':1', sample: text.slice(0, 40)});
          }
        });

        // SC 1.4.11: a filled control has to be distinguishable from what is
        // behind it, whatever its label does.
        Array.prototype.forEach.call(
          document.body.querySelectorAll('a[class*="btn"], button, input[type="submit"]'),
          function (el) {
            if (!visible(el)) return;
            var fill = parse(getComputedStyle(el).backgroundColor);
            if (!fill || fill.a === 0) return;
            var behind = el.parentElement ? background(el.parentElement) : null;
            if (!behind) return;
            fillsChecked++;
            var got = ratio(over(fill, behind), behind);
            if (got + 0.005 < FILL) {
              failures.push({kind: 'fill', selector: label(el), fg: getComputedStyle(el).backgroundColor,
                             bg: 'rgb(' + Math.round(behind.r) + ', ' + Math.round(behind.g) + ', ' + Math.round(behind.b) + ')',
                             ratio: got, need: FILL.toFixed(1) + ':1', sample: (el.textContent || '').trim().slice(0, 40)});
            }
          });

        return {failures: failures, textChecked: textChecked, fillsChecked: fillsChecked};
      })()
    JS
  end
end
