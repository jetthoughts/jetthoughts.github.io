#!/usr/bin/env bash

# CSS Migration Performance Monitor
# Tracks CSS performance metrics during migration process

set -euo pipefail

# Configuration
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
REPORTS_DIR="_reports/css_migration"
BUILD_DIR="_dest/public-dev"
BASELINE_FILE="_reports/css_performance_baseline.md"

# Performance thresholds
MAX_BUNDLE_SIZE="100000"  # 100KB in bytes
MAX_TOTAL_FILES="10"
MAX_BUILD_TIME="5000"     # 5 seconds in ms
REGRESSION_THRESHOLD="20" # 20% size increase triggers rollback

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== CSS MIGRATION PERFORMANCE MONITOR ===${NC}"
echo -e "Timestamp: ${TIMESTAMP}"
echo -e "Monitoring CSS performance during migration..."
echo ""

# Create monitoring directory
mkdir -p "${REPORTS_DIR}"

# Function to measure Hugo build performance
measure_build_performance() {
    echo -e "${BLUE}📊 Measuring Hugo build performance...${NC}"

    local build_start=$(date +%s)

    # Run Hugo build with timing
    if bin/hugo-build > "${REPORTS_DIR}/build_${TIMESTAMP}.log" 2>&1; then
        local build_end=$(date +%s)
        local build_time=$(((build_end - build_start) * 1000))

        echo "Build Time: ${build_time}ms" > "${REPORTS_DIR}/build_metrics_${TIMESTAMP}.txt"

        if [[ $build_time -gt $MAX_BUILD_TIME ]]; then
            echo -e "${RED}⚠️  Build time (${build_time}ms) exceeds ${MAX_BUILD_TIME}ms threshold${NC}"
            return 1
        else
            echo -e "${GREEN}✅ Build time (${build_time}ms) within acceptable range${NC}"
            return 0
        fi
    else
        echo -e "${RED}❌ Hugo build failed${NC}"
        return 1
    fi
}

# Function to analyze CSS bundle sizes
analyze_css_bundles() {
    echo -e "${BLUE}📦 Analyzing CSS bundle sizes...${NC}"

    local css_report="${REPORTS_DIR}/css_analysis_${TIMESTAMP}.csv"
    echo "file,size_bytes,size_kb,status" > "${css_report}"

    local total_files=0
    local oversized_files=0
    local total_size=0

    # Analyze each CSS file
    find "${BUILD_DIR}" -name "*.css" -type f | while read -r css_file; do
        local size_bytes=$(stat -f%z "${css_file}" 2>/dev/null || echo "0")
        local size_kb=$((size_bytes / 1024))
        local filename=$(basename "${css_file}")
        local status="OK"

        if [[ $size_bytes -gt $MAX_BUNDLE_SIZE ]]; then
            status="OVERSIZED"
            ((oversized_files++))
        fi

        echo "${filename},${size_bytes},${size_kb},${status}" >> "${css_report}"
        total_size=$((total_size + size_bytes))
        ((total_files++))
    done

    # Generate summary
    local avg_size=$((total_files > 0 ? total_size / total_files / 1024 : 0))
    local total_size_kb=$((total_size / 1024))

    echo "" >> "${css_report}"
    echo "SUMMARY" >> "${css_report}"
    echo "Total Files,${total_files}" >> "${css_report}"
    echo "Oversized Files,${oversized_files}" >> "${css_report}"
    echo "Total Size KB,${total_size_kb}" >> "${css_report}"
    echo "Average Size KB,${avg_size}" >> "${css_report}"

    # Quality gates
    local quality_gates_passed=0
    local total_gates=3

    echo -e "${BLUE}🎯 CSS Quality Gates:${NC}"

    # Gate 1: File count
    if [[ $total_files -le $MAX_TOTAL_FILES ]]; then
        echo -e "  ✅ File Count: ${total_files}/${MAX_TOTAL_FILES}"
        ((quality_gates_passed++))
    else
        echo -e "  ❌ File Count: ${total_files}/${MAX_TOTAL_FILES}"
    fi

    # Gate 2: Bundle sizes
    if [[ $oversized_files -eq 0 ]]; then
        echo -e "  ✅ Bundle Sizes: All under 100KB"
        ((quality_gates_passed++))
    else
        echo -e "  ❌ Bundle Sizes: ${oversized_files} files over 100KB"
    fi

    # Gate 3: Total payload
    local max_total_payload=500  # 500KB total
    if [[ $total_size_kb -le $max_total_payload ]]; then
        echo -e "  ✅ Total Payload: ${total_size_kb}KB/${max_total_payload}KB"
        ((quality_gates_passed++))
    else
        echo -e "  ❌ Total Payload: ${total_size_kb}KB/${max_total_payload}KB"
    fi

    echo -e "Quality Gates Passed: ${quality_gates_passed}/${total_gates}"

    # Return status based on gates
    if [[ $quality_gates_passed -eq $total_gates ]]; then
        return 0
    else
        return 1
    fi
}

# Function to detect performance regressions
detect_regressions() {
    echo -e "${BLUE}🔍 Detecting performance regressions...${NC}"

    local current_largest=$(find "${BUILD_DIR}" -name "*.css" -exec stat -f%z {} \; | sort -nr | head -1)
    local baseline_largest="516096"  # 504KB from baseline

    local current_largest_kb=$((current_largest / 1024))
    local baseline_largest_kb=$((baseline_largest / 1024))

    local regression_pct=$(( (current_largest - baseline_largest) * 100 / baseline_largest ))

    echo "Current largest bundle: ${current_largest_kb}KB"
    echo "Baseline largest bundle: ${baseline_largest_kb}KB"
    echo "Change: ${regression_pct}%"

    if [[ $regression_pct -gt $REGRESSION_THRESHOLD ]]; then
        echo -e "${RED}🚨 PERFORMANCE REGRESSION DETECTED: ${regression_pct}% increase${NC}"
        echo -e "${YELLOW}Rollback recommended${NC}"
        return 1
    elif [[ $regression_pct -lt -10 ]]; then
        echo -e "${GREEN}🎉 PERFORMANCE IMPROVEMENT: ${regression_pct}% reduction${NC}"
        return 0
    else
        echo -e "${GREEN}✅ Performance stable: ${regression_pct}% change${NC}"
        return 0
    fi
}

# Function to generate monitoring report
generate_monitoring_report() {
    local report_file="${REPORTS_DIR}/monitoring_report_${TIMESTAMP}.md"

    echo "# CSS Migration Monitoring Report" > "${report_file}"
    echo "**Timestamp:** $(date)" >> "${report_file}"
    echo "" >> "${report_file}"

    echo "## Build Performance" >> "${report_file}"
    if [[ -f "${REPORTS_DIR}/build_metrics_${TIMESTAMP}.txt" ]]; then
        cat "${REPORTS_DIR}/build_metrics_${TIMESTAMP}.txt" >> "${report_file}"
    fi
    echo "" >> "${report_file}"

    echo "## CSS Bundle Analysis" >> "${report_file}"
    if [[ -f "${REPORTS_DIR}/css_analysis_${TIMESTAMP}.csv" ]]; then
        echo "\`\`\`" >> "${report_file}"
        cat "${REPORTS_DIR}/css_analysis_${TIMESTAMP}.csv" >> "${report_file}"
        echo "\`\`\`" >> "${report_file}"
    fi
    echo "" >> "${report_file}"

    echo "## Recommendations" >> "${report_file}"
    echo "- Monitor bundle sizes during migration" >> "${report_file}"
    echo "- Validate Core Web Vitals impact" >> "${report_file}"
    echo "- Test rollback procedures if regressions detected" >> "${report_file}"

    echo -e "${BLUE}📋 Full report generated: ${report_file}${NC}"
}

# Main execution
main() {
    local exit_code=0

    # Measure build performance
    if ! measure_build_performance; then
        exit_code=1
    fi

    # Analyze CSS bundles
    if ! analyze_css_bundles; then
        exit_code=1
    fi

    # Detect regressions
    if ! detect_regressions; then
        exit_code=1
    fi

    # Generate monitoring report
    generate_monitoring_report

    # Final status
    if [[ $exit_code -eq 0 ]]; then
        echo -e "${GREEN}🎉 CSS migration monitoring: ALL CHECKS PASSED${NC}"
    else
        echo -e "${RED}⚠️  CSS migration monitoring: ISSUES DETECTED${NC}"
    fi

    exit $exit_code
}

# Run if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi