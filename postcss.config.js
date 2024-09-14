const purgecss = require("@fullhuman/postcss-purgecss")({
  content: ["./hugo_stats.json"],
  defaultExtractor: (content) => {
    const els = JSON.parse(content).htmlElements
    return [...(els.tags || []), ...(els.classes || []), ...(els.ids || [])]
  },
  safelist: {
    deep: [/^swiper-/, /^is-/, /^has-/, /^js-/, /^fl-builder-content/, /^fl-/, /^pp-/],
    greedy: [/^swiper-/, /^is-/, /^has-/, /^js-/, /^fl-builder-content/, /^fl-/, /^pp-/]
  },
})

module.exports = {
  plugins: [
    purgecss,
    require("autoprefixer"),
    ...(process.env.HUGO_ENVIRONMENT === "production" ? [require("cssnano")] : []),
    // ...(process.env.HUGO_ENVIRONMENT === "production" ? [purgecss, require("autoprefixer"), require("cssnano")] : []),
  ],
}
