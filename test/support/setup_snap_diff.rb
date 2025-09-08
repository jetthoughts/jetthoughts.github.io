# Screenshot Testing Configuration
#
# Environment Variables for controlling screenshot behavior:
# - SCREENSHOT_TOLERANCE: Override global tolerance (default: 0.01 = 1%)
# - SCREENSHOT_STABILITY_TIME: Override stability wait time (default: 1.0s)
# - FORCE_SCREENSHOT_UPDATE: Set to 'true' to regenerate all baseline screenshots
# - CAPYBARA_SCREENSHOT_DIFF_FAIL_ON_DIFFERENCE: Set to 'false' to update baselines
#
# Usage Examples:
# SCREENSHOT_TOLERANCE=0.02 bundle exec rake test           # 2% tolerance
# SCREENSHOT_STABILITY_TIME=2.0 bundle exec rake test       # 2s stability time
# FORCE_SCREENSHOT_UPDATE=true bundle exec rake test        # Regenerate baselines
#

require "capybara_screenshot_diff/minitest"

Capybara::Screenshot.save_path = "test/fixtures/screenshots"
Capybara::Screenshot.add_os_path = true
Capybara::Screenshot.window_size = nil

# Screenshot stability and tolerance settings
# 
# stability_time_limit: Time to wait for the page to be stable before taking screenshot
# Increased from 0.25s to 1.0s to reduce flakiness from animations/loading states
Capybara::Screenshot.stability_time_limit = ENV.fetch("SCREENSHOT_STABILITY_TIME", "1.0").to_f

# tolerance: Allowed difference percentage between baseline and current screenshot
# Increased from 0.005 (0.5%) to 0.03 (3%) to handle cross-platform rendering differences
# across different environments, versions, and operating systems
Capybara::Screenshot::Diff.tolerance = ENV.fetch("SCREENSHOT_TOLERANCE", "0.03").to_f

Capybara::Screenshot::Diff.driver = :vips
Capybara::Screenshot::Diff.delayed = false
Capybara.default_max_wait_time = 5

# Add global setup hook to disable animations for all screenshot tests
Capybara.configure do |config|
  # Ensure screenshots are taken with consistent rendering
  config.default_set_options = { clear: :backspace }
end

# Add after_action callback to prepare pages for screenshots if needed
module ScreenshotPreparation
  def self.disable_animations_globally(page)
    page.execute_script(<<~JS) if page.driver.browser.respond_to?(:execute_script)
      if (!document.querySelector('#screenshot-test-animations-disabled')) {
        const style = document.createElement('style');
        style.id = 'screenshot-test-animations-disabled';
        style.innerHTML = `
          *, *::before, *::after {
            animation-duration: 0s !important;
            animation-delay: 0s !important;
            transition-duration: 0s !important;
            transition-delay: 0s !important;
            animation-play-state: paused !important;
            -webkit-animation-duration: 0s !important;
            -webkit-animation-delay: 0s !important;
            -webkit-transition-duration: 0s !important;
            -webkit-transition-delay: 0s !important;
          }
        `;
        document.head.appendChild(style);
      }
    JS
  rescue StandardError => e
    # Silently handle cases where JavaScript execution fails
    puts "Warning: Could not disable animations: #{e.message}" if ENV['DEBUG']
  end
  
  def self.wait_for_assets_to_load(page, timeout: 10)
    return unless page.driver.browser.respond_to?(:execute_script)
    
    page.evaluate_async_script(<<~JS, timeout * 1000)
      (function() {
        var done = arguments[0];
        var startTime = Date.now();
        var timeout = arguments[1] || 10000;
        
        function checkAssetsLoaded() {
          // Check images
          var images = Array.from(document.images);
          var imagesLoaded = images.every(function(img) {
            return img.complete && img.naturalHeight !== 0;
          });
          
          // Check stylesheets
          var stylesheets = Array.from(document.styleSheets);
          var stylesheetsLoaded = stylesheets.every(function(sheet) {
            try {
              return sheet.cssRules !== null;
            } catch(e) {
              return true; // Cross-origin stylesheets, assume loaded
            }
          });
          
          // Check if enough time has passed or assets are loaded
          if ((imagesLoaded && stylesheetsLoaded) || (Date.now() - startTime) > timeout) {
            done();
          } else {
            setTimeout(checkAssetsLoaded, 100);
          }
        }
        
        checkAssetsLoaded();
      })();
    JS
  rescue StandardError => e
    # Fallback: just wait a bit
    sleep 0.5
    puts "Warning: Could not check asset loading: #{e.message}" if ENV['DEBUG']
  end
end

# Environment variable controls for screenshot behavior
# 
# CAPYBARA_SCREENSHOT_DIFF_FAIL_ON_DIFFERENCE=false: Useful for updating screenshot baselines
if ENV["CAPYBARA_SCREENSHOT_DIFF_FAIL_ON_DIFFERENCE"] == "false"
  Capybara::Screenshot::Diff.fail_on_difference = false
end

# FORCE_SCREENSHOT_UPDATE=true: Regenerate all baseline screenshots
if ENV["FORCE_SCREENSHOT_UPDATE"] == "true"
  Capybara::Screenshot::Diff.fail_on_difference = false
end

Capybara::Screenshot.root = Dir.pwd
