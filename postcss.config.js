const purgecss = require("@fullhuman/postcss-purgecss")({
  content: ["./hugo_stats.json"],
  defaultExtractor: (content) => {
    const els = JSON.parse(content).htmlElements
    return [...(els.tags || []), ...(els.classes || []), ...(els.ids || [])]
  },
  safelist: {
    standard: [
      "button, input[type=button], input[type=submit]",
      // pp adv menu
      "pp-advanced-menu", "pp-advanced-menu-accordion-collapse", "off-canvas", "pp-menu-position-below",
      "menu-close", "menu-open",
      "pp-active", "focus", "pp-menu-submenu-right", "mega-menu-disabled", "mega-menu",
      "pp-off-canvas-menu-module", "pp-off-canvas-menu-open", "pp-full-screen-menu-module",
      "pp-full-screen-menu-open", "fl-node-menu-clone", "pp-search-form--focus", "first-click",

      "pp-advanced-menu", "pp-advanced-menu-accordion-collapse", "pp-menu-default","pp-menu-align-right",
      "pp-menu-position-below", "fl-module-content","fl-node-content",

      // pp adv tabs
      "pp-tabs", "pp-tabs-label", "pp-tab-active", "pp-tabs-panel", "pp-tabs-panel-content",
      "pp-tabs-animation", "pp-no-border",
      // fl-theme
      "collapse", "fl-mobile-sub-menu-open", "current-menu-item", "fl-sub-menu-right", "fl-shrink-header-enabled",
      "fl-show", "mega-menu-disabled", "mega-menu", /^mega-menu-items-/, "fl-responsive-nav-enabled", "fl-nav-offcanvas-collapse",
    ],

    greedy: [
      /^swiper-/, /^is-/, /^has-/, /^js-/, /^fl-builder-content/, /^fl-col/, /^fl-node/
    ]
  },
})

module.exports = {
  plugins: [
    require("postcss-nested"),
    purgecss,
    require("postcss-delete-duplicate-css")({isRemoveNull: true, isRemoveComment: true}),
    ...(process.env.HUGO_ENVIRONMENT === "production" ? [require("autoprefixer"), require("cssnano")] : []),
  ],
}
