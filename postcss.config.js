// PostCSS Configuration - Environment-aware optimization
const isDevelopment = process.env.HUGO_ENVIRONMENT === "development";

// Skip expensive PurgeCSS in development for faster rebuilds
const createPurgeCss = require("@fullhuman/postcss-purgecss").default || require("@fullhuman/postcss-purgecss");

const purgecss = createPurgeCss({
  content: ["./hugo_stats.json"],
  defaultExtractor: (content) => {
    const els = JSON.parse(content).htmlElements
    return [...(els.tags || []), ...(els.classes || []), ...(els.ids || [])]
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
  // Enhanced PurgeCSS options for better optimization
  variables: true,
  fontFace: true,
  keyframes: true,
  // More aggressive CSS removal
  rejected: true,
  rejectedCss: true
});

module.exports = {
  plugins: [
    // Always include nested CSS support
    require("postcss-nested"),

    // Skip autoprefixer in development for faster processing
    isDevelopment ? null : require("autoprefixer"),

    // Skip PurgeCSS in development (major speed improvement)
    isDevelopment ? null : purgecss,

    // Skip duplicate removal in development
    isDevelopment ? null : require("postcss-delete-duplicate-css")({ isRemoveNull: true, isRemoveComment: true }),

    // Enhanced minification in production with aggressive optimization
    isDevelopment ? null : require("cssnano")({
      preset: ['default', {
        discardComments: {
          removeAll: true,
        },
        normalizeWhitespace: true,
        reduceIdents: false, // Preserve class names for compatibility
        mergeLonghand: true,
        discardDuplicates: true,
        discardEmpty: true,
        minifyFontValues: true,
        minifyGradients: true,
        minifyParams: true,
        minifySelectors: true,
        reduceTransforms: true,
        svgo: false, // Disable to prevent SVG issues
        zindex: false // Preserve z-index values for safety
      }]
    }),
  ].filter(Boolean), // Remove null plugins
};
