/**
 * Welcome to Cloudflare Workers! This is your first worker.
 *
 * - Run "npm run dev" in your terminal to start a development server
 * - Open a browser tab at http://localhost:8787/ to see your worker in action
 * - Run "npm run deploy" to publish your worker
 *
 * Learn more at https://developers.cloudflare.com/workers/
 */


const redirects = {
  '/delayedjob-and-pg-error-no-connection-to-server-9dc4b72ec44d': '/blog/delayedjob-pg-error-no-connection-server-rails-ruby/',
  '/': '/blog/',
  '/4-lines-to-speed-up-your-rails-test-suite-on-ci-744e4326e8a3': '/blog/4-lines-speed-up-your-rails-test-suite-on-circleci/',
  '/4-tricks-to-write-catchy-headlines-16d963cf5222': '/blog/4-tricks-write-catchy-headlines-contentwriting/',
  '/5-free-tools-to-make-the-sales-process-easier-9e1368d41bf0': '/blog/5-free-tools-make-sales-process-easier-leadgeneration/',
  '/5-steps-to-add-remote-modals-to-your-rails-app-8c21213b4d0c': '/blog/5-steps-add-remote-modals-your-rails-app-javascript-ruby/',
  '/8-step-sales-process-in-5-min-6381751c7a11': '/blog/8-step-sales-process-in-5-min-productivity/',
  '/a-practical-guide-to-writing-introductions-17210d563621': '/blog/practical-guide-writing-introductions-introduction/',
  '/a-typical-day-at-jetthoughts-5e25f5f803ce': '/blog/typical-day-at-jetthoughts-agile-remote/',
  '/align-remote-teams-with-okrs-and-impact-mapping-f7e43a65e347': '/blog/align-remote-teams-with-okrs-impact-mapping-management-devops/',
  '/anonymous-block-argument-in-ruby-70432da9b5c7': '/blog/anonymous-block-argument-in-ruby-tutorial/',
  '/auto-install-system-dependencies-for-ruby-on-rails-4a19c22b6d49': '/blog/auto-install-system-dependencies-for-ruby-on-rails-programming/',
  '/automated-delivery-react-vue-app-for-each-pull-request-38ecd4814803': '/blog/automated-delivery-react-vue-app-for-each-pull-request-ci/',
  '/avoid-data-migrations-in-the-schema-rb-migrations-for-rails-1baf8f5ed9ea': '/blog/avoid-data-migrations-in-schema-for-rails-ruby/',
  '/benefits-of-working-remotely-4c36456a9adb': '/blog/benefits-of-working-remotely-remote/',
  '/best-practices-for-optimizing-ruby-on-rails-performance-b62d805f6ea6': '/blog/best-practices-for-optimizing-ruby-on-rails-performance/',
  '/best-tips-for-writing-integration-tests-in-rails-d1f56081f249': '/blog/tips-for-writing-readable-system-tests-in-rails-capybara-ruby/',
  '/building-video-app-for-mobile-with-react-native-part-1-expo-e34d7f06429b': '/blog/video-player-with-react-native-part-1-expo-reactnative/',
  '/change-inputs-placeholder-color-with-css-8f6384121d8e': '/blog/change-inputs-placeholder-color-with-css-html/',
  '/cheap-tests-with-ghost-inspector-5ab299856c81': '/blog/cheap-tests-with-ghost-inspector-webdev-legacy/',
  '/checklist-for-the-non-tech-founder-5c638133f899': '/blog/checklist-for-non-tech-founder-agile/',
  '/cleaning-routines-to-keep-your-project-neat-ef2fa8dd6034': '/blog/cleaning-routines-keep-your-project-without-bugs-agile/',
  '/cleaning-up-your-rails-views-with-view-objects-42cf048ea491': '/blog/cleaning-up-your-rails-views-with-view-objects-development/',
  '/collecting-javascript-code-coverage-with-capybara-in-ruby-on-rails-application-d0cb83a86a90': '/blog/collecting-javascript-code-coverage-with-capybara-in-ruby-on-rails-application-testing/',
  '/communication-agreement-in-a-remote-environment-29ffb981ea0e': '/blog/communication-agreement-in-remote-environment-agile/',
  '/cons-of-the-private-chats-for-team-collaboration-f87c8ba8e830': '/blog/cons-of-private-chats-for-team-collaboration-communication-process/',
  '/cross-platform-development-using-reactxp-8675e451d0ab': '/blog/cross-platform-development-using-reactxp-react-javascript/',
  '/custom-ordering-without-custom-sql-with-ruby-on-rails-7-044fc0a592e8': '/blog/custom-ordering-without-sql-with-ruby-on-rails-7/',
  '/custom-templates-for-rails-scaffolding-9cb5270e3fff': '/blog/custom-templates-for-rails-scaffolding-ruby/',
  '/data-migrations-with-rails-6fa3d66f128f': '/blog/data-migrations-with-rails-ruby/',
  '/delivery-flow-for-distributed-remote-teams-5218828b0d1a': '/blog/delivery-flow-for-distributed-remote-teams-agile-kanban/',
  '/deploying-jekyll-to-github-pages-with-circleci-2-0-3eb69324bc6e': '/blog/deploying-jekyll-github-pages-with-circleci-20/',
  '/deploying-subdirectory-projects-to-heroku-f31ed65f3f2': '/blog/deploying-subdirectory-projects-heroku-git/',
  '/design-rails-json-api-with-performance-in-mind-427e0f0e6f04': '/blog/design-rails-json-api-with-performance-in-mind-cache/',
  '/effective-project-onboarding-checklist-87b95fce256b': '/blog/effective-project-onboarding-checklist-management-productivity/',
  '/effortless-code-review-for-pull-request-changes-241206b1cb04': '/blog/effortless-code-conventions-review-for-pull-request-changes-ruby-ci/',
  '/enum-validation-in-ruby-on-rails-7-1-285762a64582': '/blog/enum-validation-in-ruby-on-rails-71/',
  '/env-variables-in-ruby-on-rails-application-5552fb963051': '/blog/where-read-env-variables-in-ruby-on-rails-application/',
  '/feature-branches-and-where-to-find-them-58e898399a5e': '/blog/feature-branches-where-find-them-development-coding/',
  '/fractional-cto-a-comprehensive-review-of-the-first-two-weeks-in-a-startup-21fa34fbc2b6': '/blog/fractional-cto-comprehensive-review-of-first-two-weeks-in-startup-consulting-management/',
  '/from-what-to-start-to-stop-delivering-bugs-when-there-is-no-time-for-changes-d7499fa85fcb': '/blog/from-what-start-stop-delivering-bugs-when-there-no-time-for-changes-management-agile/',
  '/generating-random-strings-with-ruby-a2f4c6f1a7a8': '/blog/generating-random-strings-with-ruby-webdev/',
  '/git-minimum-for-effective-project-development-841a0b865ef0': '/blog/git-minimum-for-effective-project-development/',
  '/help-shepherd-to-count-sheep-in-elixir-88fefb2dce1d': '/blog/help-shepherd-count-sheep-in-elixir-programming/',
  '/how-a-large-transaction-can-be-a-source-of-db-deadlocks-and-how-this-can-be-fixed-e130075226f6': '/blog/how-large-transaction-can-be-source-of-db-deadlocks-this-fixed-ruby-database/',
  '/how-jetthoughts-implements-joels-test-96a870d0eedc': '/blog/how-jetthoughts-implements-joels-test-deveopment-management/',
  '/how-our-expertise-helped-curb-real-estate-communication-chaos-b758d5ea698': '/blog/how-our-expertise-helped-curb-real-estate-communication-chaos/',
  '/how-to-avoid-callbacks-using-services-ace238dd44ec': '/blog/how-avoid-callbacks-using-services-rails-refactoring/',
  '/how-to-avoid-n-1-query-using-sql-views-materialized-in-rails-application-7cf415cd112f': '/blog/how-avoid-n1-query-using-sql-views-materialized-in-rails-application-ruby/',
  '/how-to-create-a-technical-post-in-a-short-time-15d289a23636': '/blog/how-create-technical-post-in-short-time-writing-blogging/',
  '/how-to-create-circles-in-css-1c1f64c1a7eb': '/blog/how-create-circles-in-css-html/',
  '/how-to-create-triangles-in-css-20c70d46857b': '/blog/how-create-triangles-in-css-html/',
  '/how-to-create-triangles-in-tailwindcss-9c80006d7987': '/blog/how-create-triangles-in-tailwindcss-html-css/',
  '/how-to-get-build-full-urls-in-rails-99128ef82bc5': '/blog/how-get-build-full-urls-in-rails-ruby/',
  '/how-to-get-remote-teams-to-high-perform-b9b29d698feb': '/blog/how-get-remote-teams-high-perform-agile-development/',
  '/how-to-have-clean-css-structure-with-rscss-itcss-2afc2e309126': '/blog/how-have-clean-css-structure-with-rscssitcss-rscss/',
  '/how-to-horizontally-center-an-element-without-flex-13af946c88bf': '/blog/how-horizontally-center-an-element-without-flex-css-html/',
  '/how-to-keep-clean-ruby-on-rails-views-with-the-null-object-pattern-4b61b8f83656': '/blog/how-keep-clean-ruby-on-rails-views-with-null-object-pattern/',
  '/how-to-know-what-your-team-is-doing-816c2697c189': '/blog/how-know-what-your-team-doing-remote-startup/',
  '/how-to-learn-ruby-bd15fb731fc5': '/blog/how-learn-ruby-tutorial/',
  '/how-to-make-small-valuable-async-standups-fdd9afa32c59': '/blog/how-make-small-valuable-async-standups-productivity-development/',
  '/how-to-make-truncate-text-in-css-67c42e264680': '/blog/how-make-truncate-text-in-css-html/',
  '/how-to-make-vertically-scrollable-in-css-330669dfde84': '/blog/how-make-vertically-scrollable-in-css-html/',
  '/how-to-memoize-false-and-nil-values-fe28b8ede9f8': '/blog/how-memoize-false-nil-values-ruby-rails/',
  '/how-to-name-variables-and-methods-in-ruby-b4a21fb66c4d': '/blog/how-name-variables-methods-in-ruby-programming/',
  '/how-to-setup-a-project-that-can-host-up-to-1000-users-for-free-ab59ad3edaf1': '/blog/how-setup-project-that-can-host-up-1000-users-for-free-heroku-startup/',
  '/how-to-setup-default-values-for-attributes-in-ruby-on-rails-dd1d2ba38b82': '/blog/how-setup-default-values-for-attributes-in-ruby-on-rails-programming/',
  '/how-to-setup-incremental-design-process-in-a-startup-b3c26cbbc49d': '/blog/how-setup-incremental-design-process-in-startup/',
  '/how-to-start-an-open-source-project-building-reso-api-js-client-cee7a4cfc951': '/blog/how-start-an-open-source-project-building-reso-api-js-client-javascript-opensource/',
  '/how-to-style-a-checkbox-using-css-e04b7e80992b': '/blog/how-style-checkbox-using-css-html/',
  '/how-to-use-a-transaction-script-aka-service-objects-in-ruby-on-rails-simple-example-161b7e228942': '/blog/how-use-transaction-script-aka-service-objects-in-ruby-on-rails-simple-example/',
  '/how-to-use-background-size-in-css-7b3dcdc941d5': '/blog/how-use-background-size-in-css-html/',
  '/how-to-use-linear-gradient-in-css-4a7c0deaae75': '/blog/how-use-linear-gradient-in-css-html/',
  '/how-to-use-nth-child-in-css-83c9feab3092': '/blog/how-use-nth-child-in-css-html/',
  '/how-to-use-ruby-on-rails-concerns-919139a74e64': '/blog/how-use-ruby-on-rails-concerns-webdev/',
  '/how-to-vertically-center-an-element-without-flex-15048f60e57d': '/blog/how-vertically-center-an-element-without-flex-css-html/',
  '/how-to-work-with-external-services-in-tests-f06050343aeb': '/blog/how-handle-remote-services-in-tests-rails-tutorial/',
  '/how-to-write-the-right-content-for-your-article-e5075ad0274f': '/blog/how-write-right-content-for-your-article-blogging-posting/',
  '/how-we-configure-simplecov-for-our-ruby-on-rails-projects-21e5a4122a50': '/blog/how-we-configure-simplecov-for-our-ruby-on-rails-projects/',
  '/how-we-helped-an-existing-product-debug-grow-and-gain-more-satisfied-customers-38e17b084ac9': '/blog/how-we-helped-an-existing-product-debug-grow-gain-more-satisfied-customers-development-startup/',
  '/how-we-hire-developers-at-jetthoughts-d71e8b88e62c': '/blog/how-we-hire-developers-at-jetthoughts-recruiting-hr/',
  '/how-we-temporarily-transformed-our-usual-workflow-for-a-tight-deadline-18d05dc34134': '/blog/how-we-temporarily-transformed-our-usual-workflow-for-tight-deadline-agile/',
  '/improving-ruby-on-rails-test-suite-performance-by-disabling-animations-2950dca86b45': '/blog/improving-ruby-on-rails-test-suite-performance-by-disabling-animations-testing/',
  '/incremental-lint-fixes-by-github-actions-73f6c141bba8': '/blog/incremental-lint-fixes-by-github-actions-devops/',
  '/inexpensive-is-not-cheap-choosing-software-development-company-for-your-project-da97b7d9b3c0': '/blog/inexpensive-not-cheap-choosing-software-development-company-for-your-project-outsource-mvp/',
  '/install-official-firefox-deb-in-dockerfile-c07b8dba00c1': '/blog/install-official-firefox-deb-in-dockerfile-docker-devops/',
  '/integrating-bun-with-vite-ruby-for-lightning-fast-frontend-builds-bbd220fefdc0': '/blog/integrating-bun-with-vite-ruby-for-lightning-fast-frontend-builds-rails-javascript/',
  '/its-time-for-active-job-239f7681a3ef': '/blog/its-time-for-active-job-ruby-rails/',
  '/jetthoughts-is-recognized-by-techreviewer-as-a-top-web-development-company-in-2020-765c8b7894c6': '/blog/jetthoughts-recognized-by-techreviewer-as-top-web-development-company-in-2020-webdev/',
  '/jetthoughwe-receives-first-review-on-clutch-co-thank-you-e86879857b62': '/blog/jetthoughts-receives-first-review-on-clutchco-thank-you-startup/',
  '/latest': '/blog/',
  '/load-web-page-in-less-than-one-second-145bbfecff12': '/blog/load-web-page-in-less-than-one-second-optimization-html/',
  '/make-master-stable-again-b15c9ff3b129': '/blog/heroku-reviews-apps-prevent-delivering-bugs-on-production-ci-startup/',
  '/manage-bundler-indirect-dependencies-versions-e0ed99ac2bd5': '/blog/manage-bundler-indirect-dependencies-versions-ruby-rails/',
  '/migrate-from-sidekiq-to-sidekiq-cr-in-rails-application-8d26674d9e2a': '/blog/migrate-from-sidekiq-sidekiqcr-in-rails-application-tdd-testing/',
  '/mock-everything-is-a-good-way-to-sink-b8a1284fb81f': '/blog/mock-everything-good-way-sink-tdd-testing/',
  '/more-control-over-enum-in-rails-7-1-bb02fbc3d252': '/blog/more-control-over-enum-in-rails-71-webdev/',
  '/myth-or-reality-can-test-driven-development-in-agile-replace-qa-91b3fb08fff9': '/blog/myth-or-reality-can-test-driven-development-in-agile-replace-qa-programming/',
  '/onboarding-tests-into-legacy-project-3cd5658cc1f8': '/blog/onboarding-tests-into-legacy-project-testing-startup/',
  '/optimize-your-chrome-options-for-testing-to-get-x1-25-impact-4f19f071bf45': '/blog/optimize-your-chrome-options-for-testing-get-x125-impact-tricks/',
  '/our-default-ruby-development-stack-9d7e80ef21df': '/blog/our-default-ruby-development-stack-rails/',
  '/pay-attention-to-method-names-in-minitest-unit-80de16d9c05f': '/blog/pay-attention-method-names-in-minitestunit-testing-ruby/',
  '/pitfalls-of-using-metaprogramming-in-ruby-on-rails-application-966cf0fc9635': '/blog/pitfalls-of-using-metaprogramming-in-ruby-on-rails-application-programming/',
  '/prepare-the-pull-request-before-asking-to-review-bc95fc39eb11': '/blog/prepare-pull-request-before-asking-review-git-pullrequest/',
  '/preview-ui-changes-with-ruby-on-rails-variants-527c13bf7fd0': '/blog/preview-ui-changes-with-ruby-on-rails-variants/',
  '/rails-typescript-react-js-c52a591e8276': '/blog/react-ruby-on-rails-without-any-gems-typescript/',
  '/rails-virtual-attributes-use-cases-cf33bd45e2a4': '/blog/rails-virtual-attributes-use-cases-ruby/',
  '/react-native-testing-options-overview-3b1d55e6e6f3': '/blog/react-native-testing-options-overview/',
  '/recent-searches-sorting-hashes-how-they-are-connected-61420fc95c99': '/blog/recent-searches-sorting-hashes-how-they-are-connected-ruby-rails/',
  '/regular-automatic-dependencies-update-with-circleci-90a71893aa1a': '/blog/regular-automatic-dependencies-update-with-circleci-github-circle/',
  '/responsive-or-adaptive-design-find-out-which-one-is-better-for-you-4186ddc6e00c': '/blog/responsive-or-adaptive-design-find-out-which-one-better-for-you-webdesign/',
  '/revise-your-stylesheets-part-1-color-scheme-6125f869453b': '/blog/revise-your-stylesheets-part-1-color-scheme-webdev-css/',
  '/robots.txt': '/robots.txt',
  '/rscss-styling-css-without-losing-your-sanity-9e622d9f9252': '/blog/rscss-styling-css-without-losing-your-sanity/',
  '/running-tests-in-containers-with-docker-compose-97480726c1e3': '/blog/running-tests-in-containers-with-docker-compose-coding-tutorial/',
  '/services-and-tools-we-use-for-development-2749af5ad08a': '/blog/services-tools-automatize-development-for-remote-teams-workflow-automation/',
  '/setting-up-docker-for-ruby-on-rails-7-cd2c942c3d43': '/blog/setting-up-docker-for-ruby-on-rails-7-beginners/',
  '/simple-lead-generation-tactics-d152448e0569': '/blog/simple-lead-generation-tactics-startup-sails/',
  '/simplest-step-by-step-guide-creating-a-post-94a7fe21256d': '/blog/simplest-step-by-guide-creating-post-blogging-writing/',
  '/simultaneous-work-on-the-feature-for-frontend-and-backend-developers-73cd2ae6db90': '/blog/simultaneous-work-on-feature-for-frontend-backend-developers-development-startup/',
  '/sitemap/sitemap.xml': '/sitemap.xml',
  '/speed-up-github-prs-review-of-your-react-applications-cf3786260302': '/blog/speed-up-github-prs-review-of-your-react-applications-development-tutorial/',
  '/speed-up-your-rails-test-suite-by-6-in-1-line-13fedb869ec4': '/blog/speed-up-your-rails-test-suite-by-6-in-1-line-testing-ruby/',
  '/stimulus-keyboard-event-filter-186fde386d22': '/blog/stimulus-keyboard-event-filter/',
  '/stress-testing-your-rails-application-using-jmeter-95a201071b98': '/blog/stress-testing-your-rails-application-using-jmeter-ruby/',
  '/team-structure-for-mvp-2e19669de06': '/blog/our-mvp-team-structure-startup-management/',
  '/test-driven-thinking-for-solving-common-ruby-pitfalls-458fe6d3d856': '/blog/test-driven-thinking-for-solving-common-ruby-pitfalls-rails-tdd/',
  '/the-4-steps-to-bringing-life-to-a-struggling-project-37a53bf9c7dc': '/blog/4-steps-bring-life-into-struggling-project-startup-management/',
  '/the-simplest-way-to-automate-delivery-of-your-react-native-application-f37f2c71eb1d': '/blog/simplest-way-automate-delivery-of-your-react-native-application-android-reactnative/',
    '/the-trial-period-in-jetthoughts-968e7f01481f': '/blog/trial-period-for-staff-augmentation-in-jetthoughts-startup-engagement/',
  '/the-ultimate-guide-to-the-sales-onboarding-in-it-companies-6e8b4a4a473': '/blog/ultimate-guide-sales-onboarding-in-it-companies-sails-leadgeneration/',
  '/things-that-remote-teams-expect-from-the-product-owner-f253e429ba66': '/blog/things-that-remote-teams-expect-from-product-owner-startup/',
  '/tips-to-attract-readers-to-read-your-post-e693dfcdbeb8': '/blog/tips-attract-readers-read-your-post-blogging/',
  '/tips-to-hire-great-people-b4aebb5c8f06': '/blog/tips-hire-great-people-startup-hiring/',
  '/tl-dr-move-ci-cd-scripts-into-automation-d1cc627e542f': '/blog/tldr-move-cicd-scripts-into-automation-devops-productivity/',
  '/trending': '/blog/',
  '/tried-and-tested-ways-of-onboarding-2a1038a873': '/blog/how-does-onboarding-look-like-in-jetthoughts-productivity-startup/',
  '/troubleshooting-ruby-builds-a53f1f19b4cb': '/blog/troubleshooting-ruby-build-tutorial/',
  '/upgrading-postgresql-on-heroku-a-step-by-step-guide-bbcb4e63adb3': '/blog/upgrading-postgresql-on-heroku-step-by-guide-database/',
  '/useloom-the-best-tool-for-async-remote-communication-7bfcbbffe051': '/blog/tools-provide-effective-feedback-for-distributed-development-teams-productivity-startup/',
  '/vertical-align-with-a-full-screen-across-tailwind-css-5c6ad91c3e4f': '/blog/vertical-align-with-full-screen-across-tailwind-css-jetthoughts/',
  '/what-activities-are-expected-from-remote-developer-9dca8d192955': '/blog/what-activities-are-expected-from-remote-developer-for-effective-collaboration-development-process/',
  '/what-are-the-most-common-misconceptions-about-remote-work-62741844e78': '/blog/what-are-most-common-misconceptions-about-remote-work-misconception/',
  '/what-are-the-next-steps-when-your-project-is-failing-cb4be757101': '/blog/what-are-next-steps-when-your-project-failing-management/',
  '/what-are-the-steps-of-an-automation-test-plan-e5ba4eaf741a': '/blog/what-are-steps-of-an-automation-test-plan-qualitycontrol-testing/',
  '/what-is-ruby-on-rails-middleware-6eee8dab8c64': '/blog/what-ruby-on-rails-middleware/',
  '/what-is-the-difference-between-joins-and-includes-in-rails-activerecord-64cdbffe60b6': '/blog/what-difference-between-joins-includes-in-rails-activerecord-ruby/',
  '/what-to-do-for-the-developer-when-the-wip-limit-is-reached-3dda66a6ddbf': '/blog/what-do-for-developer-when-wip-limit-reached-agile-kanban/',
  '/which-platforms-are-better-to-use-for-clients-to-look-for-contractors-c6df66e352b3': '/blog/which-platforms-are-better-use-for-non-tech-founders-look-contractors-freelance-development/',
  '/who-is-to-blame-when-a-project-fails-595d683da73d': '/blog/who-blame-when-project-fails-blamegame/',
  '/why-and-how-to-use-tdd-main-tips-976b3a6edebb': '/blog/why-how-use-tdd-main-tips-testing/',
  '/why-communication-is-so-important-when-you-work-remotely-8f0e97652f38': '/blog/why-communication-important-when-you-work-remotely-remote/',
  '/why-is-it-hard-to-find-a-great-developer-on-upwork-and-other-freelance-platforms-87b125a87a76': '/blog/why-it-hard-find-great-developer-on-upwork-other-freelance-platforms-senior/'
}

const base = "https://jetthoughts.com";
const statusCode = 301;

export default {
  async fetch(request) {
      const url = new URL(request.url);
      const {
          pathname,
          search
      } = url;

      if (pathname === '/feed') {
        return new Response('Not Found', { status: 404 });
      }

      if (pathname.startsWith('/tags/')) {
          const destinationURL = `${base}/blog${search}`;
          console.log(destinationURL);
          return Response.redirect(destinationURL, statusCode);
      }

      if (redirects[pathname]) {
          const destinationURL = `${base}${redirects[pathname]}${search}`;
          console.log(destinationURL);
          return Response.redirect(destinationURL, statusCode);
      } else {
          return fetch(request);
      }
  },
};
