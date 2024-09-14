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
  blocklist: ["fl-theme-builder-header-sticky"]
})

module.exports = {
  plugins: [
    require("postcss-nested"),
    require("postcss-delete-duplicate-css")({isRemoveNull: true, isRemoveComment: true}),
    purgecss,
    ...(process.env.HUGO_ENVIRONMENT === "production" ? [purgecss, require("autoprefixer"), require("cssnano")] : []),
  ],
}
