require "application_system_test_case"

class CostCalculatorTest < ApplicationSystemTestCase
  def test_fractional_cto_cost_calculator_page_loads
    visit "/tools/fractional-cto-cost-calculator/"
    
    assert_text "Fractional CTO Cost Calculator"
    assert_text "Get personalized pricing"
    assert_selector "select#company-stage"
    assert_selector "select#time-commitment"
    assert_selector "select#team-size"
    assert_selector "select#expertise-level"
    assert_selector "button[onclick*='calculateCost']"
  end

  def test_rails_development_cost_calculator_page_loads
    visit "/tools/rails-development-cost-calculator/"
    
    assert_text "Ruby on Rails Development Cost Calculator"
    assert_text "Get accurate Ruby on Rails development cost estimates"
    assert_selector "select#project-type"
    assert_selector "select#timeline"
    assert_selector "select#team-model"
    assert_selector "select#feature-complexity"
    assert_selector "button[onclick*='calculateCost']"
  end

  def test_enhanced_cto_cost_calculator_page_loads
    visit "/tools/cto-cost-calculator/"
    
    assert_text "CTO Cost Calculator & Comparison Tool"
    assert_text "Compare different CTO service options"
    # Should have multiple calculator types
    assert_text "Fractional CTO Investment Calculator"
    assert_text "Startup CTO Consulting Calculator"
  end

  def test_fractional_cto_calculator_calculates_results
    visit "/tools/fractional-cto-cost-calculator/"
    
    # Fill out calculator form
    select "Growing Company (Series A) - 11-50 employees", from: "company-stage"
    select "20 hours/week (Strategic + operational guidance)", from: "time-commitment"
    select "6-15 developers (Medium team)", from: "team-size"
    select "Standard Web Technology (Rails, React, etc.)", from: "expertise-level"
    
    # Calculate should be enabled now
    refute find("button[onclick*='calculateCost']")[:disabled]
    
    # Click calculate
    click_button "Calculate Cost Estimate"
    
    # Results should appear
    assert_selector "#calculator-results", visible: true
    assert_text "$"
    assert_text "per month"
    assert_text "Your Estimated Investment"
  end

  def test_rails_calculator_calculates_results
    visit "/tools/rails-development-cost-calculator/"
    
    # Fill out calculator form
    select "SaaS Application (Multi-tenant)", from: "project-type"
    select "Standard (4-6 months)", from: "timeline"
    select "Fixed-Price Project", from: "team-model"
    select "Standard Features (Payments, APIs, Integrations)", from: "feature-complexity"
    select "Standard (Payment processors, email, analytics)", from: "integrations"
    select "Medium (1,000 - 10,000 users)", from: "user-scale"
    
    # Calculate should be enabled now
    refute find("button[onclick*='calculateCost']")[:disabled]
    
    # Click calculate
    click_button "Calculate Cost Estimate"
    
    # Results should appear
    assert_selector "#calculator-results", visible: true
    assert_text "$"
    assert_text "Your Estimated Investment"
  end

  def test_calculator_has_faq_section
    visit "/tools/fractional-cto-cost-calculator/"
    
    assert_text "Frequently Asked Questions"
    assert_selector ".faq-item"
    assert_selector "button.faq-question"
  end

  def test_calculator_has_lead_capture
    visit "/tools/fractional-cto-cost-calculator/"
    
    # Fill out calculator to see results
    select "Growing Company (Series A) - 11-50 employees", from: "company-stage"
    select "20 hours/week (Strategic + operational guidance)", from: "time-commitment"
    select "6-15 developers (Medium team)", from: "team-size"
    select "Standard Web Technology (Rails, React, etc.)", from: "expertise-level"
    
    click_button "Calculate Cost Estimate"
    
    # Lead capture should be visible after calculation
    assert_selector "#lead-capture-form", visible: true
    assert_selector "input[name='email']"
    assert_selector "input[name='company']"
    assert_selector "input[name='name']"
    assert_text "Get Your Detailed Proposal"
  end
end