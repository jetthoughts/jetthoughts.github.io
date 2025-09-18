# Middleware to log requests

require "selenium-webdriver"

# Configure Selenium to automatically manage Chrome driver
Selenium::WebDriver.logger.output = File.join(Dir.tmpdir, "selenium.log")
Selenium::WebDriver.logger.level = :warn

# Minimal Chrome arguments for maximum stability during testing
CHROME_ARGS = {
  "headless" => nil,
  "no-sandbox" => nil,
  "disable-dev-shm-usage" => nil,
  "disable-gpu" => nil,
  "disable-extensions" => nil,
  "disable-web-security" => nil,
  "disable-features" => "VizDisplayCompositor",
  "disable-background-timer-throttling" => nil,
  "disable-backgrounding-occluded-windows" => nil,
  "disable-renderer-backgrounding" => nil,
  "disable-infobars" => nil,
  "disable-popup-blocking" => nil,
  "disable-default-apps" => nil,
  "disable-hang-monitor" => nil,
  "no-first-run" => nil,
  "disable-crash-reporter" => nil,
  "disable-logging" => nil,
  "log-level" => "3",
  "silent" => nil,
  # Additional arguments for connection stability
  "disable-ipc-flooding-protection" => nil,
  "disable-session-crashed-bubble" => nil,
  "force-device-scale-factor" => "1"
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
Capybara.default_max_wait_time = ENV.fetch("CAPYBARA_WAIT_TIME", "10").to_i
Capybara.server_errors = []

Capybara.save_path = "tmp/capybara/"
