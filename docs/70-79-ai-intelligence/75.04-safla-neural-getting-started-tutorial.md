# SAFLA-Neural Code Review Getting Started Tutorial

**Type**: tutorial
**Audience**: New Users, Developers, Team Leads
**Prerequisites**: Basic Git knowledge, jt_site codebase access
**Johnny Decimal**: 75.04 (AI Intelligence → SAFLA-Neural Getting Started)
**Time Required**: 30-45 minutes
**Last Updated**: 2025-10-01

---

## What You'll Learn

This hands-on tutorial walks you through your first experience with the SAFLA-Neural Code Review System. You'll create a simple code change, see how the system reviews it, provide feedback, and observe how it learns from your input.

**By the end, you'll understand**:
- How to submit code for SAFLA-neural review
- How to interpret review findings and confidence scores
- How to provide feedback that improves the system
- How the learning cycle works in practice

**What You'll Build**: A simple CSS consolidation PR reviewed by SAFLA-neural

---

## Step 1: Verify System Is Running

**Goal**: Confirm SAFLA-neural is operational before starting

### Check System Status

Open your terminal and run:

```bash
# Navigate to jt_site repository
cd /path/to/jetthoughts.github.io

# Check memory architecture
npx claude-flow@alpha hooks memory-search --pattern "code_review/*/initialized"
```

**Expected Output**:
```
code_review/vector/initialized: "status:ready"
code_review/episodic/initialized: "status:ready"
code_review/semantic/initialized: "status:ready"
code_review/working/initialized: "status:ready"
```

✅ **Success Indicator**: All four memory tiers show `status:ready`

❌ **If Not Ready**: Follow the [Implementation How-To](75.02-safla-neural-implementation-how-to.md) to set up the system first

### Check Current Metrics

```bash
# View current system metrics
cat _runtime/safla-metrics-latest.json
```

**Expected Output**:
```json
{
  "timestamp": "2025-10-01T10:00:00Z",
  "accuracy": {
    "true_positives": 15,
    "false_positives": 3,
    "false_negatives": 1,
    "quality_score": "0.83"
  },
  "learning": {
    "patterns_learned": 8,
    "adaptations_applied": 2
  }
}
```

**What This Means**:
- System has reviewed 19 total items (15+3+1)
- Current accuracy: 83% (will improve over time)
- Already learned 8 project-specific patterns

---

## Step 2: Create Your First Review Request

**Goal**: Make a simple code change to test SAFLA-neural review

### Create a Feature Branch

```bash
# Create a new branch for your test change
git checkout -b tutorial/safla-neural-test-review

echo "✅ Branch created: tutorial/safla-neural-test-review"
```

### Make a Simple Code Change

Let's create a simple CSS duplication that SAFLA-neural should detect:

**Create file**: `src/assets/css/tutorial-test.css`

```css
/* Tutorial Test File - Contains intentional duplication */

.test-button {
  background-color: #2563eb;
  color: white;
  padding: 10px 20px;
  border-radius: 4px;
}

.test-button-secondary {
  background-color: #2563eb;  /* Duplicate from above */
  color: white;               /* Duplicate from above */
  padding: 10px 20px;         /* Duplicate from above */
  border-radius: 4px;         /* Duplicate from above */
}

.test-button-tertiary {
  background-color: #2563eb;  /* Duplicate again */
  color: white;               /* Duplicate again */
  padding: 10px 20px;         /* Duplicate again */
  border-radius: 4px;         /* Duplicate again */
}
```

### Commit the Change

```bash
# Stage the file
git add src/assets/css/tutorial-test.css

# Commit with clear message
git commit -m "Tutorial: Add test CSS file with duplication

This is a tutorial test to demonstrate SAFLA-neural review.
File intentionally contains CSS duplication for review system to detect."

echo "✅ Commit created"
```

---

## Step 3: Trigger SAFLA-Neural Review

**Goal**: Submit your change for automated review

### Push to Remote and Create PR

```bash
# Push branch to remote
git push origin tutorial/safla-neural-test-review

echo "✅ Branch pushed to remote"
echo "📝 Now create a Pull Request on GitHub"
```

### Create Pull Request

1. Go to GitHub repository: `https://github.com/your-org/jetthoughts.github.io`
2. Click "Pull requests" → "New pull request"
3. Select base: `master`, compare: `tutorial/safla-neural-test-review`
4. Fill in PR details:
   ```
   Title: Tutorial: Test SAFLA-Neural Review

   Description:
   This PR is for testing SAFLA-neural code review system.
   File contains intentional CSS duplication for review detection.

   Expected Review Findings:
   - CSS duplication detected
   - Consolidation opportunity
   ```
5. Click "Create pull request"

### Wait for Review (2-3 minutes)

GitHub Actions will trigger SAFLA-neural review automatically.

Watch the "Checks" tab for:
```
🟡 SAFLA-Neural Code Review - In Progress
```

After 2-3 minutes:
```
✅ SAFLA-Neural Code Review - Complete
```

---

## Step 4: Interpret Review Findings

**Goal**: Understand what SAFLA-neural found and how to read confidence scores

### View Review Comments

Click on the "Files changed" tab in your PR. You should see comments like:

**Review Finding #1**:
```
🤖 SAFLA-Neural Review Finding

Issue Type: CSS Duplication
Severity: Medium
Confidence: 0.87

Detected Pattern:
Multiple CSS selectors with identical property values:
- .test-button
- .test-button-secondary
- .test-button-tertiary

Suggestion:
Consider consolidating into a base class:

.test-button-base {
  background-color: #2563eb;
  color: white;
  padding: 10px 20px;
  border-radius: 4px;
}

.test-button { @extend .test-button-base; }
.test-button-secondary { @extend .test-button-base; }
.test-button-tertiary { @extend .test-button-base; }

Historical Context:
Similar CSS duplication consolidations successful in:
- PR #456: fl-foundation.css consolidation
- PR #478: beaver-grid-layout consolidation

Confidence Explanation:
High confidence (0.87) based on 12 successful similar consolidations.
```

### Understanding Confidence Scores

**Confidence Scale**:
```
0.90 - 1.00: Very High Confidence (almost certainly correct)
0.75 - 0.89: High Confidence (likely correct, few false positives)
0.60 - 0.74: Moderate Confidence (uncertain, flagged for human review)
0.00 - 0.59: Low Confidence (very uncertain, definitely needs human judgment)
```

**Our Finding**: Confidence 0.87 (High)
- System is quite confident this is a real issue
- Likely a true positive based on historical patterns
- Safe to act on this finding

**What Affects Confidence**:
- Historical accuracy for similar patterns
- Number of supporting observations
- Project-specific context alignment

---

## Step 5: Provide Feedback to Improve the System

**Goal**: Teach SAFLA-neural by providing feedback on review accuracy

### Scenario A: Finding is Correct (True Positive)

If the finding is accurate and helpful:

**Add a comment**:
```
✅ Confirmed: Excellent catch!

This is indeed redundant CSS. I'll consolidate as suggested.

@safla-neural: true-positive
```

**What Happens**:
1. System records this as a true positive
2. Confidence for similar patterns increases
3. Future CSS duplication reviews become more accurate

**Fix the code**:
```bash
# Update tutorial-test.css with consolidated version
cat > src/assets/css/tutorial-test.css << 'EOF'
/* Tutorial Test File - Consolidated Version */

.test-button-base {
  background-color: #2563eb;
  color: white;
  padding: 10px 20px;
  border-radius: 4px;
}

.test-button {
  @extend .test-button-base;
}

.test-button-secondary {
  @extend .test-button-base;
}

.test-button-tertiary {
  @extend .test-button-base;
}
EOF

# Commit the fix
git add src/assets/css/tutorial-test.css
git commit -m "Fix: Consolidate CSS duplication per SAFLA review"
git push
```

### Scenario B: Finding is Incorrect (False Positive)

If the finding is wrong or not applicable:

**Add a comment**:
```
❌ False Positive: This duplication is intentional

These button styles need to be separate for theming reasons.
Each variant will have different hover states in future PRs.

@safla-neural: false-positive
Reason: Intentional duplication for theme variants
```

**What Happens**:
1. System records this as a false positive
2. Learns context: "theme variants" → acceptable duplication
3. Future similar patterns get lower confidence scores
4. Reduces noise in future reviews

### Scenario C: Finding is Unclear (Request More Context)

If you're unsure about the finding:

**Add a comment**:
```
🤔 Unclear: Need more context

Can you explain why this is considered duplication?
The selectors target different elements.

@safla-neural: clarification-needed
```

**What Happens**:
1. System escalates to human reviewer with expertise
2. Human reviewer provides detailed explanation
3. System learns from the expert explanation
4. Improves future explanations

---

## Step 6: Observe Learning in Action

**Goal**: See how the system updates its knowledge based on your feedback

### Check Memory Updates

After providing feedback, check what the system learned:

```bash
# View recent learning extractions
npx claude-flow@alpha hooks memory-search \
  --pattern "code_review/learning/patterns/extracted/*" \
  --limit 3
```

**Expected Output**:
```
code_review/learning/patterns/extracted/1696118400/css_duplication:
  "pattern: CSS button style consolidation
   outcome: true_positive
   confidence_adjustment: +0.03 (0.87 → 0.90)
   context: Similar to PR #456, PR #478
   learning: Repeated property values indicate consolidation opportunity"
```

**What This Shows**:
- Your feedback was recorded
- Confidence score increased (system more sure next time)
- Pattern connected to historical successful consolidations

### View Updated Semantic Memory

```bash
# Check updated CSS duplication rule
npx claude-flow@alpha hooks memory-search \
  --pattern "code_review/semantic/patterns/css_duplication/*"
```

**Expected Output**:
```
code_review/semantic/patterns/css_duplication/repeated_properties:
  "confidence: 0.90 (updated from 0.87)
   true_positives: 13 (was 12)
   false_positives: 3
   pattern: Repeated identical property values across selectors
   consolidation_success_rate: 81% (13/16)
   version: 4 (updated 2025-10-01)"
```

**What Changed**:
- True positive count increased: 12 → 13
- Confidence increased: 0.87 → 0.90
- Pattern version updated (tracks evolution)

---

## Step 7: Monitor Improvement Over Time

**Goal**: Track how the system improves from your feedback

### Check Current Metrics

```bash
# View updated metrics
cat _runtime/safla-metrics-latest.json
```

**Compare to Step 1 Baseline**:
```json
Before (Step 1):
{
  "accuracy": {
    "true_positives": 15,
    "quality_score": "0.83"
  }
}

After (Step 7):
{
  "accuracy": {
    "true_positives": 16,  // +1 from your feedback
    "quality_score": "0.84" // Improved
  }
}
```

**Improvement**: +1% accuracy from a single review with feedback!

### Visualize Learning Progress

Open the metrics dashboard:

```bash
# Open dashboard in browser
open _runtime/safla-dashboard.html
```

**What You'll See**:
- Accuracy metrics chart showing upward trend
- Patterns learned count increased
- Your contribution visible in recent activity

---

## Step 8: Test Learned Knowledge

**Goal**: Verify the system learned from your feedback

### Create Similar Code Change

Create another CSS file to test if the system applies learned knowledge:

```bash
# Create new test file with similar pattern
cat > src/assets/css/tutorial-test-2.css << 'EOF'
/* Tutorial Test 2 - Similar Pattern */

.test-card {
  border: 1px solid #e5e7eb;
  padding: 16px;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.test-card-highlighted {
  border: 1px solid #e5e7eb;    /* Duplicate */
  padding: 16px;                /* Duplicate */
  border-radius: 8px;           /* Duplicate */
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);  /* Duplicate */
}
EOF

# Commit and push
git add src/assets/css/tutorial-test-2.css
git commit -m "Tutorial: Test learned CSS pattern recognition"
git push
```

### Review New Findings

Check the updated PR. SAFLA-neural should now review this with **higher confidence**:

**Expected Finding**:
```
🤖 SAFLA-Neural Review Finding

Issue Type: CSS Duplication
Severity: Medium
Confidence: 0.90  ← Higher than before (was 0.87)!

Detected Pattern:
CSS duplication similar to previous finding in tutorial-test.css

Learning Applied:
System confidence increased based on your previous feedback.
This pattern matches successfully consolidated code from:
- Your previous fix in this PR
- 12 other historical consolidations
```

**What This Demonstrates**:
- System remembered your previous feedback
- Applied learning to similar new pattern
- Increased confidence based on validated pattern

---

## What's Next: Continuing Your Learning Journey

### For Daily Use

**Best Practices**:

1. **Always provide feedback on findings**:
   - Mark true positives: `@safla-neural: true-positive`
   - Mark false positives: `@safla-neural: false-positive` + reason
   - Request clarification when unclear

2. **Trust confidence scores**:
   - High confidence (>0.85): Usually accurate, safe to act on
   - Medium confidence (0.60-0.84): Review carefully, provide feedback
   - Low confidence (<0.60): System is learning, definitely review

3. **Monitor improvement**:
   - Check dashboard weekly: `open _runtime/safla-dashboard.html`
   - Review learning reports: `ls _runtime/safla-learning-report-*.md`
   - Celebrate improvements with team!

### Advanced Usage

Once comfortable with basics, explore:

1. **Customizing Review Depth**:
   - Low-risk changes: Fast automated review
   - High-risk changes: Deep review with expert escalation

2. **Contributing Patterns**:
   - Share effective patterns via semantic memory
   - Document project-specific standards

3. **Analyzing Trends**:
   - Identify common issues across codebase
   - Track improvement velocity
   - Optimize learning cycle frequency

### Getting Help

**Resources**:
- **System Reference**: [75.01-safla-neural-code-review-system-reference.md](75.01-safla-neural-code-review-system-reference.md)
- **Implementation Guide**: [75.02-safla-neural-implementation-how-to.md](75.02-safla-neural-implementation-how-to.md)
- **Concepts Explanation**: [75.03-safla-neural-concepts-explanation.md](75.03-safla-neural-concepts-explanation.md)

**Support Channels**:
- Team Slack: `#safla-neural-reviews`
- GitHub Issues: Label with `safla-neural`
- Weekly office hours: Tuesdays 3pm

---

## Cleanup: Removing Tutorial Files

After completing the tutorial, clean up test files:

```bash
# Remove tutorial test files
git checkout master
git branch -D tutorial/safla-neural-test-review

# Delete remote branch
git push origin --delete tutorial/safla-neural-test-review

# Remove test CSS files if merged
rm -f src/assets/css/tutorial-test.css
rm -f src/assets/css/tutorial-test-2.css

echo "✅ Tutorial cleanup complete"
```

---

## Key Takeaways

**What You Learned**:

1. ✅ **System Operation**: SAFLA-neural reviews code automatically via CI/CD
2. ✅ **Confidence Scoring**: Higher confidence = more likely accurate
3. ✅ **Feedback Loop**: Your feedback directly improves the system
4. ✅ **Learning Cycle**: System extracts patterns from outcomes weekly
5. ✅ **Continuous Improvement**: Accuracy increases over time with use

**Remember**:

- **Learning takes time**: System improves most after 10-20 reviews with feedback
- **Your feedback matters**: Every true/false positive marking trains the system
- **Confidence evolves**: Scores become more accurate as system learns
- **Project-specific**: System learns YOUR codebase's unique patterns

**The Promise**: A code reviewer that gets smarter every week, learns from your team's expertise, and continuously improves quality without increasing workload.

---

## Next Steps

**Immediate** (Today):
- ✅ Complete this tutorial
- Share experience with team
- Start using for real PRs

**This Week**:
- Provide feedback on 5+ reviews
- Monitor metrics dashboard
- Share interesting findings in team chat

**This Month**:
- Review first learning cycle report
- Analyze accuracy improvements
- Propose optimizations based on team experience

**Congratulations!** You've completed the SAFLA-Neural tutorial. You're now ready to use the system for real code reviews and contribute to its continuous improvement.

---

## Document Metadata

- **AC.ID**: 75.04
- **Diátaxis Type**: tutorial
- **Creation Date**: 2025-10-01
- **Last Updated**: 2025-10-01
- **Johnny Decimal Area**: 75 (AI Intelligence)
- **Time Required**: 30-45 minutes
- **Prerequisites**: Git basics, jt_site access

---

*This tutorial provides hands-on experience with the SAFLA-Neural Code Review System, demonstrating the feedback loop and learning process through a practical example.*
