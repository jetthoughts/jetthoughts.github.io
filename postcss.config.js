const purgecss = require("@fullhuman/postcss-purgecss")({
  content: ["./hugo_stats.json"],
  defaultExtractor: (content) => {
    const els = JSON.parse(content).htmlElements
    return [...(els.tags || []), ...(els.classes || []), ...(els.ids || [])]
  },
  safelist: {
    standard: [
      "button, input[type=button], input[type=submit]",
      "pp-advanced-menu", "pp-advanced-menu-accordion-collapse", "off-canvas", "pp-menu-position-below", "menu-close", "menu-open"
    ],
    greedy: [
      /^swiper-/, /^is-/, /^has-/, /^js-/,
      /^fl-builder-content/, /^fl-col/,
      /^pp-/,
      'menu'
    ]
  },
})

module.exports = {
  content: ["layouts/**/*.html"],
  css: ["static/css/*.css"],
  whitelist: [],
  plugins: [
    require("autoprefixer"),
    require("cssnano")
    // purgecss
    // ...(process.env.HUGO_ENVIRONMENT === "production" ? [purgecss] : []),
  ],
}
