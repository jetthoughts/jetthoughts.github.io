# Performance Benchmarking Strategy for Schema Cleanup
**Date:** September 14, 2025
**Agent:** ANALYST (Hive Mind Collective)
**Purpose:** Establish baseline metrics and monitoring for microdata attribute removal

## 1. Baseline Performance Metrics

### 1.1 Hugo Build Performance (Current Baseline)
```yaml
Hugo Build Metrics (from test:build):
- Total Duration: ~120 seconds (2 minutes)
- Memory Peak: 1.3GB allocated
- Memory Total: 22.1GB over build lifecycle
- Garbage Collections: 110 cycles
- Pages Processed: 579 pages
- Resources Processed: 1,435 resources
- Static Files: 2,014 files total
```

### 1.2 Template Processing Metrics
```yaml
Critical Template Performance:
- Process Step: 341ms (file collection + processing)
- Assemble Step: 67ms (final assembly)
- Static Sync: 2.3ms (asset copying)
- Permalink Generation: ~0.5ms per page (estimated)
```

### 1.3 Memory Allocation Pattern
```yaml
Memory Usage Progression:
- Start: 136MB allocated
- Mid-build: 400-500MB range
- Peak Processing: 1.0GB+ (template rendering)
- Final: 400-600MB range
- GC Cycles: Consistent every ~200MB allocation
```

## 2. Performance Monitoring Framework

### 2.1 Build Performance Tracking
```bash
# Pre-cleanup baseline capture
echo "=== BASELINE METRICS CAPTURE ===" > performance_baseline.log
time hugo build --renderToMemory --environment production \
  --logLevel debug --templateMetrics --printMemoryUsage \
  >> performance_baseline.log 2>&1

# Post-cleanup comparison
echo "=== POST-CLEANUP METRICS ===" > performance_post_cleanup.log
time hugo build --renderToMemory --environment production \
  --logLevel debug --templateMetrics --printMemoryUsage \
  >> performance_post_cleanup.log 2>&1

# Performance diff analysis
diff -u performance_baseline.log performance_post_cleanup.log
```

### 2.2 Page-Level Performance Metrics
```yaml
Key Performance Indicators:
- HTML Payload Size: Measure per template type
- DOM Node Count: Before/after microdata removal
- Template Render Time: Hugo template metrics
- Memory Per Page: Allocation during rendering
```

### 2.3 Lighthouse Performance Monitoring
```bash
# Baseline capture for critical pages
mkdir -p _playground/lighthouse_baseline/
bin/lighthouse --output json --output html \
  --output-path _playground/lighthouse_baseline/homepage
bin/lighthouse --output json --output html \
  --output-path _playground/lighthouse_baseline/blog_post \
  --url "http://localhost:1313/blog/sample-post/"
bin/lighthouse --output json --output html \
  --output-path _playground/lighthouse_baseline/service_page \
  --url "http://localhost:1313/services/sample-service/"
```

## 3. Performance Comparison Framework

### 3.1 HTML Payload Analysis
```yaml
Measurement Strategy:
- Template Types: home, single, services, use-cases
- Sample Size: 5 pages per template type
- Metrics: Raw HTML size, gzipped size, DOM nodes
- Tools: Hugo built-in metrics + custom analysis

Expected Improvements:
- Microdata Attributes: ~50-80 attributes removed
- Payload Reduction: 2-3KB per page (estimated)
- DOM Simplification: 5-10% fewer nodes
```

### 3.2 Rendering Performance
```yaml
Hugo Template Metrics:
- Parse Time: Template compilation duration
- Execute Time: Template execution with data
- Memory Usage: Allocation during rendering
- Cache Efficiency: Template cache hit rates

Browser Metrics:
- Parse HTML: DOM construction time
- Layout: Reflow timing
- Paint: Rendering performance
```

### 3.3 Core Web Vitals Impact
```yaml
Expected Improvements:
LCP (Largest Contentful Paint):
- Current: Baseline to be established
- Target: 0-50ms improvement (minor but positive)
- Measurement: Lighthouse CI + field data

FID (First Input Delay):
- Expected Change: Minimal (no JS changes)
- Monitoring: Continue baseline tracking

CLS (Cumulative Layout Shift):
- Expected Change: None (no layout changes)
- Validation: Maintain current scores
```

## 4. Monitoring Implementation Plan

### 4.1 Pre-Implementation Baseline
```bash
# Step 1: Capture comprehensive baseline
./bin/performance-baseline-capture.sh

# Step 2: Document critical page samples
./bin/lighthouse-baseline-all.sh

# Step 3: HTML size analysis
./bin/html-payload-analysis.sh --baseline

# Step 4: Template metrics capture
hugo build --templateMetrics --templateMetricsHints \
  > _playground/template_metrics_baseline.log
```

### 4.2 During Implementation Monitoring
```bash
# Per-phase validation
./bin/performance-validation.sh --phase 1  # Documentation cleanup
./bin/performance-validation.sh --phase 2  # Non-critical templates
./bin/performance-validation.sh --phase 3  # Core templates
```

### 4.3 Post-Implementation Analysis
```yaml
Success Metrics:
Build Performance:
- Duration: Maintain or improve (target: ±5%)
- Memory: Reduce peak usage (target: -2-5%)
- Template Render: Improve efficiency (target: -1-3%)

Page Performance:
- HTML Size: Reduce payload (target: -2-3KB)
- DOM Nodes: Reduce complexity (target: -5-10%)
- Lighthouse Score: Improve or maintain (target: +1-3)

Core Web Vitals:
- LCP: Improve or maintain (target: +0-50ms)
- FID: Maintain current performance
- CLS: Maintain current scores
```

## 5. Performance Validation Scripts

### 5.1 Automated Baseline Capture
```bash
#!/bin/bash
# bin/performance-baseline-capture.sh

echo "🔍 Capturing Performance Baseline..."
mkdir -p _playground/performance_baseline/

# Hugo build metrics
echo "📊 Hugo Build Performance..."
time hugo build --renderToMemory --environment production \
  --logLevel info --templateMetrics --printMemoryUsage \
  > _playground/performance_baseline/hugo_build_metrics.log 2>&1

# Template-specific metrics
echo "🏗️  Template Performance Analysis..."
hugo build --templateMetrics --templateMetricsHints \
  > _playground/performance_baseline/template_metrics.log 2>&1

# HTML payload analysis
echo "📄 HTML Payload Analysis..."
./bin/html-size-analysis.sh --output _playground/performance_baseline/html_sizes.json

echo "✅ Baseline capture complete!"
```

### 5.2 Performance Comparison Tool
```bash
#!/bin/bash
# bin/performance-compare.sh

BASELINE_DIR="_playground/performance_baseline"
CURRENT_DIR="_playground/performance_current"

echo "📊 Performance Comparison Report"
echo "================================"

# Build time comparison
echo "🏗️  Build Performance:"
baseline_time=$(grep "Total in" $BASELINE_DIR/hugo_build_metrics.log || echo "N/A")
current_time=$(grep "Total in" $CURRENT_DIR/hugo_build_metrics.log || echo "N/A")
echo "  Baseline: $baseline_time"
echo "  Current:  $current_time"

# Memory usage comparison
echo "🧠 Memory Usage:"
baseline_peak=$(grep "Alloc.*GB" $BASELINE_DIR/hugo_build_metrics.log | tail -1 || echo "N/A")
current_peak=$(grep "Alloc.*GB" $CURRENT_DIR/hugo_build_metrics.log | tail -1 || echo "N/A")
echo "  Baseline Peak: $baseline_peak"
echo "  Current Peak:  $current_peak"

# HTML size comparison
echo "📄 HTML Payload:"
./bin/html-size-diff.sh $BASELINE_DIR/html_sizes.json $CURRENT_DIR/html_sizes.json
```

## 6. Alert Thresholds & Rollback Triggers

### 6.1 Performance Regression Thresholds
```yaml
Critical Thresholds (Immediate Rollback):
- Build Time: >10% increase
- Memory Usage: >15% increase
- Lighthouse Score: >5 point decrease
- Template Errors: Any new errors

Warning Thresholds (Investigation Required):
- Build Time: >5% increase
- Memory Usage: >10% increase
- Lighthouse Score: >3 point decrease
- HTML Validation: New warnings
```

### 6.2 Success Validation Criteria
```yaml
Required Outcomes (Must Meet All):
- Build Performance: No regression >5%
- Template Rendering: No errors introduced
- HTML Validation: No new errors
- Lighthouse Score: No decrease >3 points

Target Outcomes (Nice to Have):
- Build Time: 2-5% improvement
- Memory Usage: 2-5% reduction
- HTML Payload: 2-3KB reduction per page
- Lighthouse Score: 1-3 point improvement
```

## 7. Coordination with Hive Mind

### 7.1 Shared Performance Metrics
```yaml
RESEARCHER Agent:
- Industry benchmarks for schema performance ✅
- Best practices for Hugo optimization ✅

ANALYST Agent (Current):
- Baseline metrics establishment ✅
- Performance monitoring framework ✅
- Success criteria definition ✅

TESTER Agent:
- Performance test automation 🔄
- Validation script development 🔄
- Regression testing protocols 🔄

IMPLEMENTATION Agent:
- Performance-aware cleanup execution 🔄
- Incremental validation during changes 🔄
- Performance optimization opportunities 🔄
```

### 7.2 Performance Review Checkpoints
- **Pre-Phase:** Baseline confirmation
- **Mid-Phase:** Incremental validation
- **Post-Phase:** Full performance audit
- **Final Review:** Success criteria validation

## 8. Next Steps

1. **Coordinate with TESTER agent** for validation script development
2. **Establish baseline metrics** using Hugo build and Lighthouse
3. **Implement performance monitoring** throughout cleanup phases
4. **Validate success criteria** post-implementation

---

**Performance Framework Ready:** Awaiting hive mind coordination for baseline establishment and monitoring implementation.