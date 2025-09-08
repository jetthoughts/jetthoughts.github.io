const fs = require("fs");

const purgecss = require("@fullhuman/postcss-purgecss")({
  content: fs.existsSync("./hugo_stats.json") ? ["./hugo_stats.json"] : [],
  defaultExtractor: (content) => {
    if (!content) return [];
    try {
      const els = JSON.parse(content).htmlElements;
      return [...(els.tags || []), ...(els.classes || []), ...(els.ids || [])];
    } catch (e) {
      return [];
    }
  },
  safelist: {
    standard: [
      "button, input[type=button], input[type=submit]",

      // pp adv tabs
      "pp-tabs", "pp-tabs-label", "pp-tab-active", "pp-tabs-panel", "pp-tabs-panel-content",
      "pp-tabs-animation", "pp-no-border",

      // fl-theme
      "collapse", "fl-mobile-sub-menu-open", "current-menu-item", "fl-sub-menu-right", "fl-shrink-header-enabled",
      "fl-show", "mega-menu-disabled", "mega-menu", /^mega-menu-items-/, "fl-responsive-nav-enabled",
      "fl-nav-offcanvas-collapse",

      // sdb
      "jt-active",

      "comment-link",
    ],

    deep: [
      /^fl-page/, /^navigation/, /^menu-close/, /^top-panel/, /^menu-opener/
    ],

    greedy: [
      /^swiper-/, /^is-/, /^has-/, /^js-/, /^fl-builder-content/, /^fl-col/, /^fl-node/, /^technologies-component/, /^footer-component/, /^use-cases/
    ]
  },
})

module.exports = {
  plugins: [
    require("postcss-nested"),
    purgecss,
    require("postcss-delete-duplicate-css")({ isRemoveNull: true, isRemoveComment: true }),
    ...(process.env.HUGO_ENVIRONMENT === "production" ? [require("autoprefixer"), require("cssnano")] : []),
  ],
}
