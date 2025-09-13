# Middleware to log requests

require "selenium-webdriver"

# Essential Chrome arguments only - fail fast if any cause issues
CHROME_ARGS = {
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
  "disable-features" => "TranslateUI,BlinkGenPropertyTrees,LazyImageLoading",
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
  "use-mock-keychain" => nil
}

def build_options_for(opts)
  options = Selenium::WebDriver::Chrome::Options.new

  opts.each do |key, value|
    if value.nil?
      options.add_argument("--#{key}")
    else
      options.add_argument("--#{key}=#{value}")
    end
  end
  options
end

def register_chrome_driver(name, device_metrics)
  Capybara.register_driver name do |app|
    options = build_options_for(CHROME_ARGS)
    options.add_emulation(device_metrics: device_metrics)

    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end
end

register_chrome_driver(:desktop_chrome, {width: 1920, height: 1080, pixelRatio: 1, touch: false})
register_chrome_driver(:mobile_chrome, {width: 360, height: 800, pixelRatio: 1, touch: true})

Capybara.javascript_driver = :desktop_chrome
Capybara.current_driver = Capybara.javascript_driver
Capybara.disable_animation = true
Capybara.threadsafe = false
Capybara.default_max_wait_time = 10

Capybara.save_path = "tmp/capybara/"
