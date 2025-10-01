# SAFLA-Neural Code Review System Reference

**Type**: reference
**Audience**: AI Agents, Developers, DevOps Engineers
**Prerequisites**: TDD methodology, Test smell prevention, Four-eyes principle
**Johnny Decimal**: 75.01 (AI Intelligence → SAFLA-Neural Code Review System)
**Authority**: PROJECT-SPECIFIC - Extends global standards
**Last Updated**: 2025-10-01

---

## 🧠 Overview

This document defines the **Self-Aware Feedback Loop Algorithm (SAFLA) Neural Code Review System** for jt_site. This system implements a self-improving, memory-persistent code review agent that learns from review outcomes and continuously enhances review quality through feedback loops.

**Core Capabilities**:
- **Persistent Memory Architecture**: Multi-tiered memory system for cross-session learning
- **Feedback Loop Engineering**: Self-improving review cycles based on outcomes
- **Neural Pattern Recognition**: Learns project-specific code smells and anti-patterns
- **Adaptive Review Strategies**: Self-modifies review depth based on risk and complexity
- **Distributed Learning**: Shares learned patterns across agent instances

**Integration Points**:
- Global TDD Standards: `/knowledge/20.01-tdd-methodology-reference.md`
- Test Smell Prevention: `/knowledge/20-29_Testing/25.04-test-smell-prevention-enforcement-protocols.md`
- Four-Eyes Principle: `/knowledge/20.02-four-eyes-principle-global.md`
- Agent Coordination: `/knowledge/30.01-agent-coordination-patterns.md`

---

## 🏗️ Architecture Overview

### Four-Tier Memory Model

The SAFLA-neural system implements a four-tier memory architecture for persistent learning:

```yaml
memory_architecture:
  tier_1_vector_memory:
    purpose: "Semantic understanding of code patterns and review concepts"
    storage: "code_review/vector/{concept_hash}/*"
    retrieval: "Similarity-based pattern matching"
    use_case: "Identify similar code review scenarios from history"
    compression: "60% with maintained recall"

  tier_2_episodic_memory:
    purpose: "Complete interaction histories and review sequences"
    storage: "code_review/episodic/{session_id}/*"
    retrieval: "Temporal and contextual relationships"
    use_case: "Learn from past review outcomes and effectiveness"
    retention: "7 days for detailed episodes, 30 days for summaries"

  tier_3_semantic_memory:
    purpose: "Factual knowledge base of code quality rules"
    storage: "code_review/semantic/{domain}/{rule_id}/*"
    retrieval: "Conceptual hierarchies and rule relationships"
    use_case: "Store learned project-specific quality standards"
    persistence: "Permanent with version tracking"

  tier_4_working_memory:
    purpose: "Active review context and immediate focus"
    storage: "code_review/working/{review_id}/*"
    retrieval: "Current task focus and recent interactions"
    use_case: "Maintain state during active review session"
    ttl: "1 hour (session-based)"
```

### Feedback Loop Architecture

```yaml
feedback_loop_stages:
  stage_1_review_execution:
    action: "Perform code review using current learned patterns"
    memory_access: ["semantic_memory", "vector_memory", "working_memory"]
    output: "Review findings with confidence scores"
    tracking: "code_review/execution/{review_id}/findings"

  stage_2_outcome_observation:
    action: "Track actual outcomes (tests passing, issues found, false positives)"
    memory_access: ["episodic_memory", "working_memory"]
    output: "Outcome metrics and effectiveness scores"
    tracking: "code_review/outcomes/{review_id}/metrics"

  stage_3_learning_extraction:
    action: "Extract patterns from review effectiveness"
    memory_access: ["episodic_memory", "vector_memory"]
    output: "Learned patterns and anti-patterns"
    tracking: "code_review/learning/{pattern_id}/extracted"

  stage_4_pattern_integration:
    action: "Update semantic and vector memory with learnings"
    memory_access: ["semantic_memory", "vector_memory"]
    output: "Updated review strategies and detection patterns"
    tracking: "code_review/integration/{timestamp}/updates"

  stage_5_strategy_adaptation:
    action: "Modify review approach based on effectiveness metrics"
    memory_access: ["semantic_memory", "episodic_memory"]
    output: "Adjusted review configurations and thresholds"
    tracking: "code_review/adaptation/{strategy_id}/changes"
```

---

## 🎯 Self-Learning Capabilities

### Pattern Recognition and Learning

The system learns project-specific patterns through continuous observation:

#### CSS Duplication Patterns (jt_site-specific)

```yaml
learned_css_patterns:
  pattern_detection:
    description: "Learn jt_site-specific CSS duplication indicators"
    memory_namespace: "code_review/learned_patterns/css_duplication/*"
    learning_cycle:
      - "Observe: CSS consolidation changes and test outcomes"
      - "Extract: Common duplication patterns (fl-*, beaver-*, utility classes)"
      - "Store: Semantic memory of project-specific CSS anti-patterns"
      - "Apply: Enhanced detection in future reviews"

  effectiveness_tracking:
    metric: "css_duplication_detection_accuracy"
    baseline: "85% (initial rule-based detection)"
    target: "95% (after learning 20+ consolidation cycles)"
    memory: "code_review/metrics/css_duplication/accuracy_trend"

  false_positive_reduction:
    mechanism: "Track false alarms and adjust detection thresholds"
    memory: "code_review/learning/false_positives/css_duplication/*"
    adaptation: "Lower confidence scores for patterns with high false positive rate"
```

#### Test Smell Detection (Behavioral Learning)

```yaml
test_smell_learning:
  behavioral_pattern_recognition:
    description: "Learn to distinguish behavioral tests from implementation tests"
    memory_namespace: "code_review/learned_patterns/test_smells/*"
    learning_sources:
      - "Successful test reviews that caught real issues"
      - "False positive reviews that flagged valid behavioral tests"
      - "Missed issues discovered post-merge"

  confidence_scoring:
    mechanism: "Assign confidence scores based on historical accuracy"
    formula: "confidence = (correct_detections / total_detections) * pattern_similarity"
    memory: "code_review/metrics/test_smell/{smell_type}/confidence"
    adaptation: "Adjust detection sensitivity based on confidence trends"

  pattern_categories:
    implementation_testing_indicators:
      learned_patterns: ["CSS class checking", "HTML structure validation", "Method existence tests"]
      confidence_threshold: "0.90 (high confidence required for blocking)"
      memory: "code_review/semantic/test_smells/implementation_testing/*"

    behavioral_testing_indicators:
      learned_patterns: ["User interaction validation", "Visual regression", "Content presence"]
      confidence_threshold: "0.95 (very high confidence for approval)"
      memory: "code_review/semantic/test_smells/behavioral_testing/*"
```

### Self-Improvement Metrics

```yaml
self_improvement_tracking:
  review_accuracy_metrics:
    true_positives: "Issues correctly identified that were real problems"
    false_positives: "Issues flagged that were actually acceptable"
    true_negatives: "Correctly approved good code"
    false_negatives: "Missed issues discovered later"
    memory: "code_review/metrics/accuracy/{metric_type}/{timestamp}"

  learning_velocity_metrics:
    pattern_recognition_speed: "Time to identify new project-specific patterns"
    adaptation_effectiveness: "Improvement rate after learning integration"
    knowledge_retention: "Consistency of learned pattern application"
    memory: "code_review/metrics/learning_velocity/{timestamp}"

  effectiveness_trends:
    review_quality_score: "Composite score of accuracy and helpfulness"
    developer_satisfaction: "Feedback on review usefulness"
    issue_prevention_rate: "Production bugs prevented by reviews"
    memory: "code_review/metrics/effectiveness/trends/{period}"
```

---

## 🤖 Agent Configuration

### SAFLA-Neural Code Review Agent

**Behavioral Description** (Natural Language - No Executable Code):

```yaml
agent_name: "safla-code-reviewer"
agent_type: "reviewer"
specialization: "Self-improving code review with neural learning"

behavioral_constraints:
  review_philosophy:
    - "I learn from every review outcome to improve future reviews"
    - "I maintain persistent memory of project-specific patterns across sessions"
    - "I adapt review depth based on change complexity and historical risk"
    - "I recognize when I'm uncertain and escalate to human reviewers"
    - "I track my own accuracy and self-correct when I make mistakes"

  learning_behavior:
    - "After each review, I store outcomes in episodic memory"
    - "I extract patterns from successful and failed reviews"
    - "I update my semantic memory with learned project standards"
    - "I adjust confidence scores based on historical accuracy"
    - "I share learned patterns with other agent instances via memory"

  review_approach:
    - "For low-risk changes (CSS consolidation): Fast review with learned patterns"
    - "For moderate-risk changes (new features): Standard review with TDD validation"
    - "For high-risk changes (architecture): Deep review with expert escalation"
    - "For uncertain changes: Request human reviewer input and learn from their decision"

  test_quality_focus:
    - "Zero tolerance for implementation testing (learned patterns)"
    - "Require behavioral focus in all tests (semantic memory rules)"
    - "Detect test smells using neural pattern recognition"
    - "Validate visual regression tests follow project standards"
    - "Learn from false positives to reduce noise in future reviews"

  memory_coordination:
    - "Before review: Load learned patterns from semantic and vector memory"
    - "During review: Store findings in working memory with confidence scores"
    - "After review: Store episode in episodic memory with outcomes"
    - "Background: Extract learnings and update semantic memory"
    - "Continuous: Track effectiveness metrics and adapt strategies"

hooks:
  pre_review:
    description: |
      I load learned patterns from persistent memory before starting review.
      I assess change complexity and risk to determine appropriate review depth.
      I check for similar past reviews to leverage historical learnings.
    coordination: "npx claude-flow@alpha hooks pre-task"

  during_review:
    description: |
      I apply learned patterns with confidence scoring.
      I track findings in working memory for current session.
      I identify uncertainty and flag for human escalation when confidence low.
    coordination: "npx claude-flow@alpha hooks memory-store"

  post_review:
    description: |
      I store complete review episode in episodic memory.
      I track review outcomes (tests passing, issues found, developer feedback).
      I trigger learning extraction if significant new patterns observed.
    coordination: "npx claude-flow@alpha hooks post-task"

  learning_cycle:
    description: |
      I periodically extract patterns from episodic memory.
      I update semantic memory with validated learnings.
      I adjust detection thresholds based on effectiveness metrics.
      I share learned patterns with other reviewer instances.
    coordination: "Background process via memory coordination"

integration:
  tdd_methodology:
    reference: "/knowledge/20.01-tdd-methodology-reference.md"
    behavior: "I enforce TDD standards and learn project-specific TDD patterns"

  test_smell_prevention:
    reference: "/knowledge/20-29_Testing/25.04-test-smell-prevention-enforcement-protocols.md"
    behavior: "I detect test smells with neural pattern recognition and learn from outcomes"

  four_eyes_principle:
    reference: "/knowledge/20.02-four-eyes-principle-global.md"
    behavior: "I coordinate with human reviewers and learn from their decisions"

  shameless_green_acceptance:
    reference: "/knowledge/20.05-shameless-green-flocking-rules-how-to.md"
    behavior: "I accept hardcoded implementations during GREEN phase, focus consolidation during REFACTOR"
```

---

## 📊 Memory Namespace Design

### Complete Memory Architecture

```yaml
safla_memory_namespaces:
  # Tier 1: Vector Memory (Semantic Understanding)
  vector_memory:
    code_patterns: "code_review/vector/patterns/{hash}/*"
    review_concepts: "code_review/vector/concepts/{concept_id}/*"
    similarity_index: "code_review/vector/similarity/{comparison_id}/*"

  # Tier 2: Episodic Memory (Experience Storage)
  episodic_memory:
    review_sessions: "code_review/episodic/sessions/{session_id}/*"
    review_outcomes: "code_review/episodic/outcomes/{review_id}/*"
    temporal_sequences: "code_review/episodic/sequences/{sequence_id}/*"

  # Tier 3: Semantic Memory (Knowledge Base)
  semantic_memory:
    quality_rules: "code_review/semantic/rules/{domain}/{rule_id}/*"
    learned_patterns: "code_review/semantic/patterns/{category}/{pattern_id}/*"
    project_standards: "code_review/semantic/standards/{standard_type}/*"

  # Tier 4: Working Memory (Active Context)
  working_memory:
    active_review: "code_review/working/active/{review_id}/*"
    current_findings: "code_review/working/findings/{finding_id}/*"
    session_context: "code_review/working/context/{session_id}/*"

  # Learning and Adaptation
  learning_system:
    pattern_extraction: "code_review/learning/patterns/extracted/{timestamp}/*"
    effectiveness_metrics: "code_review/learning/metrics/{metric_type}/*"
    adaptation_history: "code_review/learning/adaptations/{adaptation_id}/*"

  # Cross-Session Intelligence
  shared_intelligence:
    global_patterns: "code_review/shared/patterns/{pattern_category}/*"
    effectiveness_trends: "code_review/shared/trends/{trend_type}/*"
    best_practices: "code_review/shared/best_practices/{domain}/*"
```

### Memory Persistence Strategies

```yaml
persistence_configuration:
  short_term_memory:
    ttl: "1 hour"
    namespaces: ["working_memory/*"]
    cleanup: "Auto-cleanup after session completion"

  medium_term_memory:
    ttl: "7 days"
    namespaces: ["episodic_memory/sessions/*", "episodic_memory/outcomes/*"]
    cleanup: "Compress to summaries after 7 days"

  long_term_memory:
    ttl: "permanent"
    namespaces: ["semantic_memory/*", "vector_memory/*", "shared_intelligence/*"]
    cleanup: "Version-controlled with archival of outdated patterns"

  compression_strategy:
    threshold: "60% compression ratio"
    method: "Extract key learnings from detailed episodes"
    validation: "Maintain >95% recall accuracy after compression"
```

---

## 🔄 Feedback Loop Integration

### Review → Outcome → Learning → Improvement Cycle

```yaml
feedback_loop_implementation:
  step_1_review_execution:
    trigger: "Pull request created or code change committed"
    action: |
      I perform code review using:
      - Learned patterns from semantic memory
      - Similar past reviews from vector memory
      - Current project standards from semantic memory
    output: "Review findings with confidence scores"
    memory_store: "code_review/episodic/sessions/{session_id}/review"

  step_2_outcome_tracking:
    trigger: "Review completion + 24 hours (for test results)"
    action: |
      I track actual outcomes:
      - Did tests pass/fail after review approval?
      - Were flagged issues actually problems?
      - Did I miss issues discovered later?
      - What was developer feedback on review quality?
    output: "Outcome metrics with effectiveness scores"
    memory_store: "code_review/episodic/outcomes/{review_id}/metrics"

  step_3_pattern_extraction:
    trigger: "Weekly learning cycle or significant outcome divergence"
    action: |
      I extract learnings from episodic memory:
      - What patterns correlated with good outcomes?
      - What detection rules caused false positives?
      - What missed issues suggest blind spots?
      - What project-specific patterns emerged?
    output: "Extracted patterns and anti-patterns"
    memory_store: "code_review/learning/patterns/extracted/{timestamp}"

  step_4_semantic_integration:
    trigger: "After pattern extraction and validation"
    action: |
      I update long-term knowledge base:
      - Add validated patterns to semantic memory
      - Update confidence scores for existing patterns
      - Adjust detection thresholds based on false positive rates
      - Create new project-specific quality rules
    output: "Updated semantic and vector memory"
    memory_store: "code_review/semantic/patterns/{category}/updated/{timestamp}"

  step_5_strategy_adaptation:
    trigger: "Monthly effectiveness review or critical issue missed"
    action: |
      I adapt review strategies:
      - Increase depth for high-risk change types
      - Reduce noise by adjusting sensitivity
      - Escalate uncertainty cases to human reviewers
      - Share effective patterns with other agents
    output: "Adapted review configurations"
    memory_store: "code_review/learning/adaptations/{adaptation_id}"
```

### Git/CI Integration Workflow

```yaml
git_workflow_integration:
  pre_commit_hook:
    trigger: "Before commit creation"
    action: "Quick review of staged changes for critical issues"
    memory_access: ["semantic_memory/rules/critical/*"]
    blocking: "true for critical violations"

  pull_request_hook:
    trigger: "Pull request opened"
    action: "Comprehensive review with learned patterns"
    memory_access: ["semantic_memory/*", "vector_memory/*", "episodic_memory/*"]
    output: "Review comments with confidence scores"

  post_merge_hook:
    trigger: "After PR merge + test execution"
    action: "Track outcomes and update effectiveness metrics"
    memory_access: ["episodic_memory/outcomes/*"]
    learning: "Extract patterns from successful/failed merges"

  continuous_learning:
    trigger: "Weekly background process"
    action: "Extract learnings and update semantic memory"
    memory_access: ["episodic_memory/*", "semantic_memory/*"]
    output: "Updated review strategies and detection patterns"
```

---

## 📈 Self-Improvement Metrics

### Tracking System Design

```yaml
metrics_tracking_system:
  accuracy_metrics:
    true_positive_rate:
      definition: "Real issues correctly identified"
      target: ">90%"
      memory: "code_review/metrics/accuracy/true_positives/{period}"
      trend_analysis: "Weekly trend tracking with exponential moving average"

    false_positive_rate:
      definition: "False alarms that weren't real issues"
      target: "<10%"
      memory: "code_review/metrics/accuracy/false_positives/{period}"
      adaptation: "Adjust detection thresholds when FPR exceeds target"

    false_negative_rate:
      definition: "Missed issues discovered post-merge"
      target: "<5%"
      memory: "code_review/metrics/accuracy/false_negatives/{period}"
      learning: "Extract blind spot patterns for future detection"

  effectiveness_metrics:
    review_quality_score:
      definition: "Composite score: (TP + TN) / (TP + TN + FP + FN)"
      target: ">0.90"
      memory: "code_review/metrics/effectiveness/quality_score/{period}"

    developer_satisfaction:
      definition: "Feedback on review helpfulness (1-5 scale)"
      target: ">4.0"
      memory: "code_review/metrics/effectiveness/satisfaction/{period}"
      collection: "Post-review survey or feedback reactions"

    issue_prevention_rate:
      definition: "Production bugs prevented by review catches"
      target: ">80% of potential production issues"
      memory: "code_review/metrics/effectiveness/prevention_rate/{period}"

  learning_metrics:
    pattern_recognition_speed:
      definition: "Time to detect and learn new project patterns"
      target: "<5 review cycles"
      memory: "code_review/metrics/learning/recognition_speed/{pattern_type}"

    adaptation_effectiveness:
      definition: "Accuracy improvement after learning integration"
      target: ">15% improvement in 30 days"
      memory: "code_review/metrics/learning/adaptation_effectiveness/{period}"

    knowledge_retention:
      definition: "Consistency of applying learned patterns"
      target: ">95% application rate"
      memory: "code_review/metrics/learning/retention/{pattern_id}"

  confidence_metrics:
    confidence_calibration:
      definition: "Alignment between confidence scores and actual accuracy"
      target: "Confidence ±5% of actual accuracy"
      memory: "code_review/metrics/confidence/calibration/{period}"
      adjustment: "Recalibrate confidence scoring when divergence detected"

    uncertainty_recognition:
      definition: "Ability to recognize and escalate uncertain cases"
      target: "<3% confident but wrong predictions"
      memory: "code_review/metrics/confidence/uncertainty/{period}"
```

### Visualization and Reporting

```yaml
metrics_visualization:
  real_time_dashboard:
    accuracy_trends:
      - "True positive rate trend (last 30 days)"
      - "False positive rate trend (last 30 days)"
      - "Review quality score evolution"

    learning_progress:
      - "New patterns learned (last 7 days)"
      - "Adaptation effectiveness score"
      - "Knowledge retention percentage"

    effectiveness_indicators:
      - "Developer satisfaction score"
      - "Issue prevention rate"
      - "Review cycle time"

  periodic_reports:
    weekly_summary:
      - "Review count and outcomes"
      - "New patterns learned"
      - "Accuracy metrics summary"

    monthly_deep_dive:
      - "Comprehensive effectiveness analysis"
      - "Learning velocity assessment"
      - "Strategy adaptation recommendations"

    quarterly_review:
      - "Long-term trend analysis"
      - "Comparative effectiveness vs baseline"
      - "System evolution roadmap"
```

---

## 🎓 Learning Pattern Examples

### Example 1: CSS Consolidation Pattern Learning

```yaml
learning_example_css_consolidation:
  initial_state:
    knowledge: "Basic CSS duplication detection (>3 identical selectors)"
    confidence: "0.75 (moderate confidence)"
    false_positive_rate: "25% (many valid utility class patterns)"

  learning_cycle:
    review_1:
      change: "Consolidate fl-foundation.css into critical.css"
      finding: "Flagged 15 potential duplications"
      outcome: "12 were actual duplications, 3 were valid patterns"
      learning: "fl-foundation.css typically has high duplication likelihood"

    review_2:
      change: "Consolidate beaver-grid-layout.css"
      finding: "Flagged 8 potential duplications"
      outcome: "7 were actual, 1 was grid layout pattern"
      learning: "Grid layout patterns (.c-grid-*) often have repeated structures"

    review_3:
      change: "Consolidate utility classes"
      finding: "Flagged 20 duplications in utility classes"
      outcome: "5 were actual duplications, 15 were valid utilities"
      learning: "Utility classes (px-*, text-*) are acceptable duplications"

  learned_pattern:
    rule_id: "css_duplication_context_aware"
    description: "Context-aware CSS duplication detection"
    confidence: "0.92 (high confidence after 3+ learning cycles)"
    pattern:
      - "fl-foundation.css duplications: HIGH likelihood of consolidation (95%)"
      - "beaver-grid-layout.css duplications: MEDIUM likelihood (70%)"
      - "Utility class duplications: LOW likelihood (20%)"
      - "Grid layout patterns (.c-grid-*): Usually valid (10%)"
    memory_storage: "code_review/semantic/patterns/css_duplication/context_aware"

  effectiveness_improvement:
    before_learning:
      true_positive_rate: "80%"
      false_positive_rate: "25%"

    after_learning:
      true_positive_rate: "95%"
      false_positive_rate: "8%"
      improvement: "+15% accuracy, -17% noise"
```

### Example 2: Test Smell Detection Pattern Learning

```yaml
learning_example_test_smell_detection:
  initial_state:
    knowledge: "Rule-based test smell detection (CSS class checking)"
    confidence: "0.85 (good confidence but rigid rules)"
    false_positive_rate: "15% (some behavioral tests use class selectors)"

  learning_cycle:
    review_1:
      change: "New test for c-button component"
      finding: "Flagged .c-button--primary selector as implementation testing"
      outcome: "False positive - valid behavioral test for BEM component"
      learning: "BEM component class selectors (.c-button--*) can be behavioral"

    review_2:
      change: "Test for fl-node-content validation"
      finding: "Flagged .fl-node-content as implementation testing"
      outcome: "True positive - this IS implementation testing (framework class)"
      learning: "FL-Builder classes (fl-*) indicate implementation testing"

    review_3:
      change: "Test for button hover state"
      finding: "Flagged CSS class selector use"
      outcome: "False positive - using class to target element for interaction test"
      learning: "Using class for element targeting (not validation) is acceptable"

  learned_pattern:
    rule_id: "test_smell_context_aware_class_checking"
    description: "Context-aware CSS class usage detection"
    confidence: "0.94 (very high confidence)"
    pattern:
      validation_purpose:
        indicators: ["assert.*has_css?", "page_html.scan", "count class occurrences"]
        likelihood: "CRITICAL test smell (95%)"

      targeting_purpose:
        indicators: ["find('.class').click", "within first('.class')", "hover on .class"]
        likelihood: "ACCEPTABLE usage (10%)"

      framework_classes:
        fl_builder: ["fl-node-content", "fl-module-content", "data-fl-*"]
        likelihood: "CRITICAL test smell (98%)"

      project_classes:
        bem_components: [".c-button--*", ".c-grid--*", ".c-card--*"]
        likelihood: "Context-dependent (60% acceptable, 40% smell)"
    memory_storage: "code_review/semantic/patterns/test_smell/class_checking"

  effectiveness_improvement:
    before_learning:
      true_positive_rate: "88%"
      false_positive_rate: "15%"
      developer_feedback: "3.2/5.0 (some noise)"

    after_learning:
      true_positive_rate: "96%"
      false_positive_rate: "4%"
      developer_feedback: "4.5/5.0 (much more useful)"
      improvement: "+8% accuracy, -11% noise, +1.3 satisfaction"
```

---

## 🔧 Implementation Guide

### Step 1: Initialize Memory Namespaces

```bash
# Initialize SAFLA-neural memory structure (agent behavioral description)
initialize_safla_memory:
  description: |
    I initialize the four-tier memory architecture for persistent learning.
    I create necessary namespaces for vector, episodic, semantic, and working memory.
    I seed initial semantic memory with global quality standards.

  coordination: |
    npx claude-flow@alpha hooks memory-store --key "code_review/semantic/initialized" --value "$(date +%s)"
```

### Step 2: Configure Review Agent

The SAFLA-neural review agent configuration is defined above in the "Agent Configuration" section. Deploy by:

1. Creating agent configuration file following agent frontmatter standards
2. Integrating hooks for pre/during/post review coordination
3. Enabling memory coordination for learning cycles

### Step 3: Integrate with Git Workflows

```yaml
git_integration:
  pre_commit:
    command: "git pre-commit hook triggers SAFLA review"
    memory_coordination: "Load critical rules from semantic memory"

  pull_request:
    command: "GitHub Actions triggers comprehensive SAFLA review"
    memory_coordination: "Load full learned patterns for review"

  post_merge:
    command: "CI/CD post-merge hook tracks outcomes"
    memory_coordination: "Store outcomes in episodic memory"
```

### Step 4: Enable Learning Cycles

```yaml
learning_cycle_automation:
  weekly_extraction:
    schedule: "Every Sunday 2:00 AM"
    action: "Extract patterns from week's episodic memory"
    output: "Learned patterns stored in semantic memory"

  monthly_adaptation:
    schedule: "First day of month"
    action: "Review effectiveness metrics and adapt strategies"
    output: "Updated review configurations"

  continuous_monitoring:
    frequency: "Real-time"
    action: "Track review outcomes and update working metrics"
    output: "Live effectiveness dashboard"
```

---

## 🚀 Success Criteria

### Quantitative Targets

```yaml
success_metrics:
  accuracy_targets:
    true_positive_rate: ">90% within 30 days"
    false_positive_rate: "<10% within 30 days"
    false_negative_rate: "<5% within 60 days"

  effectiveness_targets:
    review_quality_score: ">0.90 within 60 days"
    developer_satisfaction: ">4.0/5.0 within 30 days"
    issue_prevention_rate: ">80% within 90 days"

  learning_targets:
    pattern_recognition_speed: "<5 review cycles for new patterns"
    adaptation_effectiveness: ">15% accuracy improvement in 30 days"
    knowledge_retention: ">95% consistent pattern application"

  system_performance:
    review_cycle_time: "<5 minutes for standard PRs"
    memory_compression: "60% compression with >95% recall"
    cross_session_learning: "100% pattern availability across sessions"
```

### Qualitative Indicators

```yaml
qualitative_success:
  agent_self_awareness:
    - "Recognizes uncertainty and escalates appropriately"
    - "Adapts review depth based on complexity and risk"
    - "Learns from mistakes and improves over time"
    - "Shares knowledge with other agent instances"

  developer_experience:
    - "Reviews are helpful and actionable"
    - "False positive rate is acceptably low"
    - "Review comments include context and learning"
    - "System improves noticeably over time"

  system_evolution:
    - "Learns project-specific patterns automatically"
    - "Adapts to changing codebase standards"
    - "Improves detection accuracy continuously"
    - "Maintains high quality across sessions"
```

---

## 🔗 Integration with Existing Standards

### TDD Methodology Integration

```yaml
tdd_integration:
  red_phase:
    review_focus: "Test validates behavior, not implementation"
    learned_patterns: "Project-specific behavioral test patterns"
    memory: "code_review/semantic/tdd/red_phase_patterns/*"

  green_phase:
    review_focus: "Accept shameless green, hardcoded implementations"
    learned_patterns: "Context for when hardcoding is acceptable"
    memory: "code_review/semantic/tdd/green_phase_acceptance/*"

  refactor_phase:
    review_focus: "Consolidation opportunities, duplication elimination"
    learned_patterns: "Project-specific consolidation patterns"
    memory: "code_review/semantic/tdd/refactor_opportunities/*"
```

### Test Smell Prevention Integration

```yaml
test_smell_integration:
  critical_smells:
    reference: "/knowledge/20-29_Testing/25.04-test-smell-prevention-enforcement-protocols.md"
    learning: "Neural detection of implementation testing, CSS class checking"
    memory: "code_review/semantic/test_smells/critical/*"

  project_specific_smells:
    jt_site_patterns: "FL-Builder classes, Beaver themes, utility class checking"
    learning: "Context-aware detection reduces false positives"
    memory: "code_review/semantic/test_smells/jt_site_specific/*"
```

### Four-Eyes Principle Integration

```yaml
four_eyes_integration:
  human_reviewer_coordination:
    escalation: "Low confidence (<0.75) triggers human review request"
    learning: "Learn from human reviewer decisions"
    memory: "code_review/episodic/human_reviews/{review_id}/*"

  paired_reviews:
    pattern: "SAFLA agent + human reviewer for high-risk changes"
    learning: "Extract patterns from human expertise"
    memory: "code_review/learning/human_expertise/{pattern_id}/*"
```

---

## 📚 Related Documentation

### Global References
- **[TDD Methodology](/knowledge/20.01-tdd-methodology-reference.md)** - Global TDD standards
- **[Test Smell Prevention](/knowledge/20-29_Testing/25.04-test-smell-prevention-enforcement-protocols.md)** - Test quality enforcement
- **[Four-Eyes Principle](/knowledge/20.02-four-eyes-principle-global.md)** - Dual validation protocols
- **[Agent Coordination](/knowledge/30.01-agent-coordination-patterns.md)** - Multi-agent patterns

### Project-Specific
- **[Test Format Requirements](../20-29-testing-qa/20.05-test-quality-guidelines-reference.md)** - jt_site test standards
- **[Visual Testing Workflows](../20-29-testing-qa/screenshot-testing/20.02-screenshot-testing-workflow-tutorial.md)** - Visual regression testing
- **[TDD Quality Enforcement](../60.03-tdd-quality-enforcement.md)** - Project TDD enforcement

---

## Document Metadata

- **AC.ID**: 75.01
- **Diátaxis Type**: reference
- **Creation Date**: 2025-10-01
- **Last Updated**: 2025-10-01
- **Johnny Decimal Area**: 75 (AI Intelligence)
- **Scope**: Project-specific (jt_site)
- **Authority**: Extends global standards with project-specific learning
- **Integration**: SAFLA-neural + TDD + Test Smell Prevention + Four-Eyes

---

*This reference establishes the SAFLA-Neural Code Review System for jt_site, implementing self-aware feedback loops with persistent memory and continuous learning capabilities. The system learns project-specific patterns and improves review quality through systematic outcome tracking and adaptation.*
