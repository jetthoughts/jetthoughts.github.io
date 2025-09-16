# Visual QA Validation Criteria

## 📋 Document Classification
- **Area**: 60-69 Quality & Standards
- **Type**: Validation Standards
- **Authority**: Project Standard (superseded by global `/knowledge/` if conflicts arise)
- **Framework**: Diátaxis - Reference guide for standardized quality criteria

## 🎯 Purpose

This document defines objective, measurable criteria for visual quality assessment in the JetThoughts Hugo site. These criteria support the zero-defect QA methodology by providing clear thresholds for acceptable visual quality.

## 📊 Quality Scoring System

### 10/10 - Perfect (Grade A)
**Pixel-perfect consistency, professional appearance**

**Criteria:**
- ✅ Screenshot file size 50KB - 2MB (optimal compression)
- ✅ Consistent timestamp naming convention (`YYYYMMDD_HHMMSS`)
- ✅ No visual artifacts or rendering issues
- ✅ Proper browser viewport utilization (>800px width visible)
- ✅ All page elements fully loaded and rendered
- ✅ Cross-section visual consistency maintained

**Use Case:** Production-ready deployments, client presentations

---

### 9/10 - Excellent (Grade A-)
**< 2% difference, imperceptible issues**

**Criteria:**
- ✅ Screenshot file size 40KB - 3MB (acceptable range)
- ✅ Minor timing variations in capture (<0.1s difference impact)
- ⚠️ Negligible font rendering differences across platforms
- ✅ All critical elements properly captured
- ✅ Color accuracy within acceptable browser variance

**Use Case:** High-quality production releases, stakeholder reviews

---

### 8/10 - Very Good (Grade B)
**< 5% difference, minor issues**

**Criteria:**
- ✅ Screenshot file size 30KB - 4MB (extended acceptable range)
- ⚠️ Minor load timing impacts (some elements partially loaded)
- ⚠️ Small viewport inconsistencies (<50px difference)
- ⚠️ Minimal cross-browser rendering variations
- ✅ Core functionality and layout intact

**Use Case:** Development testing, internal quality checks

---

### 7/10 - Good (Grade C)
**< 10% difference, noticeable issues**

**Criteria:**
- ⚠️ Screenshot file size 20KB - 5MB (broader tolerance)
- ⚠️ Noticeable timing issues (loading states captured)
- ⚠️ Some elements may be partially rendered
- ⚠️ Minor layout shifts or spacing inconsistencies
- ✅ Page structure and content recognizable

**Use Case:** Minimum acceptable quality threshold, requires improvement plan

---

### Below 7/10 - Needs Improvement (Grade D-F)
**Significant problems requiring fixes**

**Failing Criteria:**
- ❌ Screenshot file size <20KB or >5MB (capture issues)
- ❌ Major timing problems (blank or error states)
- ❌ Significant visual artifacts or corruption
- ❌ Layout completely broken or unrecognizable
- ❌ Missing critical page elements
- ❌ Browser errors or console issues affecting display

**Action Required:** Must be fixed before production deployment

## 🔍 Detailed Assessment Categories

### 1. File Technical Quality (25% weight)
```ruby
# File size analysis
excellent: 50KB - 2MB    # Optimal compression and detail
good:      30KB - 4MB    # Acceptable range
poor:      <30KB or >5MB # Technical issues

# Naming consistency
required_pattern: /section_[a-z_]+_\d{8}_\d{6}\.png/
```

### 2. Visual Rendering Quality (30% weight)
- **Font rendering**: Sharp, anti-aliased text
- **Image quality**: No compression artifacts
- **Color accuracy**: Consistent across captures
- **Element sharpness**: No blur or pixelation

### 3. Layout Consistency (25% weight)
- **Section alignment**: Consistent spacing and positioning
- **Typography**: Uniform font sizes and line heights
- **Box model**: Consistent padding, margins, borders
- **Grid alignment**: Elements properly aligned

### 4. Capture Completeness (20% weight)
- **Full element visibility**: No cropped critical content
- **Loading state**: All elements fully rendered
- **Interactive states**: Proper default state captured
- **Viewport utilization**: Optimal screen real estate usage

## 🎯 Tolerance Settings by Use Case

### Production Deployment
```yaml
tolerance_threshold: 0.02  # 2% maximum difference
minimum_score: 9.0         # Grade A- minimum
requires_manual_review: false
auto_deployment: true
```

### Staging Validation
```yaml
tolerance_threshold: 0.05  # 5% maximum difference
minimum_score: 8.0         # Grade B minimum
requires_manual_review: true
auto_deployment: conditional
```

### Development Testing
```yaml
tolerance_threshold: 0.10  # 10% maximum difference
minimum_score: 7.0         # Grade C minimum
requires_manual_review: false
auto_deployment: false
```

### Experimental Features
```yaml
tolerance_threshold: 0.20  # 20% maximum difference
minimum_score: 6.0         # Grade D minimum
requires_manual_review: true
auto_deployment: never
```

## 🔧 Cross-Platform Considerations

### Browser Variance Tolerance
```ruby
# Acceptable differences between browsers
font_rendering: 1.5%      # Anti-aliasing differences
color_accuracy: 1.0%      # Color profile variations
layout_precision: 0.5%    # Sub-pixel positioning
image_compression: 2.0%   # Browser image handling
```

### Viewport Standardization
```ruby
# Standard test viewports
desktop: { width: 1920, height: 1080 }
laptop:  { width: 1366, height: 768 }
tablet:  { width: 768, height: 1024 }
mobile:  { width: 375, height: 667 }
```

## 📈 Quality Metrics Calculation

### Individual Screenshot Score
```ruby
def calculate_screenshot_score(screenshot)
  base_score = 7.0  # Starting point

  # File size assessment
  base_score += file_size_bonus(screenshot.size)
  base_score -= file_size_penalty(screenshot.size)

  # Technical quality
  base_score += rendering_quality_bonus(screenshot)
  base_score -= corruption_penalty(screenshot)

  # Consistency factors
  base_score += consistency_bonus(screenshot)
  base_score -= variance_penalty(screenshot)

  # Bounds checking
  [0, [base_score, 10].min].max
end
```

### Overall Quality Score
```ruby
def calculate_overall_score(screenshots)
  individual_scores = screenshots.map(&:score)

  # Weighted average with penalty for variance
  base_average = individual_scores.sum.to_f / individual_scores.length
  variance_penalty = calculate_variance_penalty(individual_scores)

  final_score = base_average - variance_penalty
  [0, [final_score, 10].min].max
end
```

## 🚨 Red Flag Indicators

### Immediate Rejection Criteria
- **File corruption**: Unable to read image data
- **Size anomalies**: <10KB (likely empty) or >10MB (capture failure)
- **Timestamp gaps**: >5 minute gap between related screenshots
- **Missing elements**: Critical page sections not captured
- **Error states**: Browser errors or console issues visible

### Warning Indicators
- **Inconsistent timing**: Variable load states across captures
- **Quality variance**: >2 point difference between section scores
- **Platform differences**: >5% difference between browser captures
- **Performance impact**: Screenshot capture taking >5 seconds

## 🔄 Iterative Improvement Process

### 1. Assessment Phase
```bash
# Initial validation
./bin/visual-qa-validate

# Expected output: Overall score with specific issues identified
```

### 2. Analysis Phase
```bash
# Detailed analysis mode
./bin/visual-qa-validate --improve

# Expected output: Prioritized issue list with fix suggestions
```

### 3. Fix Phase
```bash
# Apply highest-impact fixes first
# Target one issue at a time for minimal risk
```

### 4. Verification Phase
```bash
# Verify improvements
./bin/visual-qa-validate --verify

# Expected output: Score comparison with rollback recommendation if regression
```

### 5. Rollback Protocol
```bash
# If verification shows score decrease
git checkout -- .  # Rollback changes
git status          # Verify clean state

# Then try alternative fix approach
```

## 📚 Integration with Existing Infrastructure

### Test Infrastructure Usage
```ruby
# Leverages existing bin/test and Ruby test suite
test_runner: "./bin/test test/system/visual_quality_review_test.rb"
screenshot_source: "_verification/screenshots/"
analysis_engine: "File-based heuristics with Ruby"
```

### Capybara Integration
```ruby
# Uses existing Capybara configuration
browser_driver: :desktop_chrome
screenshot_method: "page.save_screenshot"
element_capture: "element.save_screenshot"
wait_strategy: "existing ApplicationSystemTestCase setup"
```

### Hugo Build Integration
```ruby
# Integrates with Hugo development workflow
build_trigger: "hugo server --buildDrafts"
test_pages: ["/about-us/", "/services/", "/contact/"]
asset_optimization: "PostCSS + Hugo Pipes"
```

## 🏆 Success Metrics

### Daily Quality Gates
- **Minimum passing score**: 7.0/10 for development
- **Production threshold**: 9.0/10 for deployment
- **Regression tolerance**: No score decrease allowed
- **Consistency requirement**: <1.0 variance between sections

### Weekly Quality Trends
- **Score improvement**: +0.5 points per iteration cycle
- **Issue reduction**: 50% fewer red flags weekly
- **Consistency improvement**: <0.5 variance across all pages
- **Performance optimization**: <3 second full validation time

---

## 📖 Reference Links

- **Implementation**: `bin/visual-qa-validate` - Main validation script
- **Test Infrastructure**: `bin/test` - Existing test runner
- **Screenshot System**: `test/system/visual_quality_review_test.rb`
- **Verification Guide**: `_verification/AGENT_UI_VERIFICATION_GUIDE.md`
- **Workflow Documentation**: `docs/visual-qa-workflow.md`

---

*This document establishes objective quality criteria for visual validation. Use `./bin/visual-qa-validate --help` for implementation details.*