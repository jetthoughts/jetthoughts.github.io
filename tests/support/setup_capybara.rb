# Middleware to log requests

CHROME_OPTIONS = {
  "allow-running-insecure-content" => nil,
  "autoplay-policy" => "user-gesture-required",
  "disable-add-to-shelf" => nil,
  "disable-background-networking" => nil,
  "disable-background-timer-throttling" => nil,
  "disable-backgrounding-occluded-windows" => nil,
  "disable-breakpad" => nil,
  "disable-checker-imaging" => nil,
  "disable-client-side-phishing-detection" => nil,
  "disable-component-extensions-with-background-pages" => nil,
  "disable-datasaver-prompt" => nil,
  "disable-default-apps" => nil,
  "disable-desktop-notifications" => nil,
  "disable-dev-shm-usage" => nil,
  "disable-domain-reliability" => nil,
  "disable-extensions" => nil,
  "disable-features" => "TranslateUI,BlinkGenPropertyTrees",
  "disable-gpu" => nil,
  "disable-hang-monitor" => nil,
  "disable-infobars" => nil,
  "disable-ipc-flooding-protection" => nil,
  "disable-logging" => nil,
  "disable-notifications" => nil,
  "disable-popup-blocking" => nil,
  "disable-prompt-on-repost" => nil,
  "disable-renderer-backgrounding" => nil,
  "disable-setuid-sandbox" => nil,
  "disable-site-isolation-trials" => nil,
  "disable-sync" => nil,
  "disable-web-security" => nil,
  "enable-automation" => nil,
  "force-color-profile" => "srgb",
  "force-device-scale-factor" => "1",
  "headless" => nil,
  "ignore-certificate-errors" => nil,
  "incognito" => nil,
  "js-flags" => "--random-seed=1157259157",
  "metrics-recording-only" => nil,
  "mute-audio" => nil,
  "no-default-browser-check" => nil,
  "no-first-run" => nil,
  "no-sandbox" => nil,
  "password-store" => "basic",
  "test-type" => nil,
  "use-mock-keychain" => nil,
  # "window-size" => "2048,1536"
}

CHROME_ARGS = CHROME_OPTIONS.map { |k, v| ["--#{k}", v].compact.join("=") }.freeze

require "capybara/cuprite"

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    # screen_size: [2048, 1536],
    # browser_options: CHROME_OPTIONS,
    # headless: "new",
    # inspector: true,
    # js_errors: true
  )
end

Capybara.javascript_driver = :cuprite
Capybara.current_driver = Capybara.javascript_driver
Capybara.disable_animation = true
Capybara.threadsafe = false