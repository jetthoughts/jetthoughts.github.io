# SAFLA XP Coordination - Quick Reference Card

**For**: Daily use by team members, coaches, and administrators
**Version**: 1.0
**Last Updated**: 2025-10-01

---

## 🚀 Quick Start Commands

### Check System Status
```bash
# Overall system health
npx claude-flow@alpha monitoring status
npx claude-flow@alpha agent list | grep "safla"

# Learning progress (episode count)
npx claude-flow@alpha memory search --pattern "safla-xp/episodes/*" | wc -l

# Validated patterns (what system learned)
npx claude-flow@alpha memory search --pattern "safla-xp/patterns/*/optimal"
```

### Start Monitored Practice Session
```bash
# Pair Programming
npx claude-flow@alpha agent spawn --type "pair-facilitator-safla"

# TDD Cycle
npx claude-flow@alpha agent spawn --type "tdd-coordinator-safla"

# Full XP Coordination
npx claude-flow@alpha agent spawn --type "xp-coordinator-safla"
```

### Manual Feedback Loop Trigger (Testing)
```bash
# Trigger learning cycle (normally runs nightly at 2 AM)
npx claude-flow@alpha workflow execute --name "SAFLA Feedback Loop Automation"

# Check workflow status
npx claude-flow@alpha workflow status --name "SAFLA Feedback Loop Automation"
```

---

## 📊 Memory Namespace Quick Reference

### Where Things Are Stored

| What | Namespace Pattern | TTL |
|------|-------------------|-----|
| **Practice Sessions** | `safla-xp/episodes/{practice}/*` | 7 days |
| **Optimal Patterns** | `safla-xp/patterns/{practice}/{context}/optimal` | 30 days |
| **Anti-Patterns** | `safla-xp/patterns/{practice}/{context}/anti` | 30 days |
| **Active Session** | `safla-xp/session/current/*` | 1 hour |
| **Satisfaction Surveys** | `safla-xp/surveys/satisfaction` | 30 days |

### Common Queries

```bash
# View recent pair programming sessions
npx claude-flow@alpha memory search \
  --pattern "safla-xp/episodes/pair-programming" \
  --sort "timestamp DESC" \
  --limit 5

# View learned pairing patterns
npx claude-flow@alpha memory search \
  --pattern "safla-xp/patterns/pair-programming/*/optimal"

# View anti-patterns (warnings)
npx claude-flow@alpha memory search \
  --pattern "safla-xp/patterns/*/anti"

# Check active session context
npx claude-flow@alpha memory search \
  --pattern "safla-xp/session/current/context"
```

---

## 🎯 Agent Quick Reference

### When to Use Which Agent

| Situation | Agent | Purpose |
|-----------|-------|---------|
| **General XP Work** | `xp-coordinator-safla` | Overall practice coordination |
| **Pair Programming** | `pair-facilitator-safla` | Rotation timing, engagement |
| **TDD Cycle** | `tdd-coordinator-safla` | Strategy selection, phase management |
| **Violation Detection** | `reflection-protocol-safla` | Trigger calibration, 5-Why |

### Agent Behaviors

**Pair Facilitator**:
- ⏰ Adjusts rotation timing (15-35 min based on context)
- 👁️ Monitors Navigator engagement
- 🤝 Detects Driver struggle signals

**TDD Coordinator**:
- 🔴 Validates RED phase (test fails first)
- 🟢 Recommends strategy (Fake It/Obvious/Triangulation)
- 🔵 Guides REFACTOR (flocking rules, step sizes)

**XP Coordinator**:
- 🧠 Orchestrates all practice monitoring
- 🔄 Executes feedback loop
- 📊 Tracks effectiveness metrics

**Reflection Protocol**:
- 🛑 Classifies triggers (violation vs frustration)
- 🔍 Executes 5-Why investigations
- 📝 Persists incident learnings

---

## 📈 Success Metrics Reference

### Target Outcomes (90 Days)

| Metric | Baseline | Target | Current |
|--------|----------|--------|---------|
| **Cycle Time** | Baseline | -20% | Track weekly |
| **Rollback Rate** | Baseline | -50% | Track weekly |
| **Test Quality** | 90% | 95% | Track daily |
| **Pair Productivity** | Baseline | +15% | Track weekly |
| **TDD Compliance** | - | >95% | Track daily |
| **Micro-Commit Size** | - | <50 lines | Track daily |

### Dashboard Access

```bash
# View metrics dashboard
npx claude-flow@alpha metrics dashboard

# Query specific metric
npx claude-flow@alpha metrics query --metric "coordination_effectiveness.cycle_time"
```

---

## 🔄 Learning Cycle Timeline

### What to Expect

**Weeks 1-2** (Baseline Establishment):
- System monitors silently
- No recommendations yet
- Baseline metrics established

**Weeks 3-4** (Pattern Recognition):
- First patterns validated (after 10+ sessions)
- Initial recommendations appear
- Trust the learning

**Weeks 5-8** (Strategy Adaptation):
- Multiple patterns active
- Personalized coordination
- Proactive warnings

**Weeks 9+** (Continuous Improvement):
- Fully autonomous optimization
- Measurable effectiveness gains
- Team-specific intelligence

### Current Progress Check

```bash
# How many sessions captured?
npx claude-flow@alpha memory search --pattern "safla-xp/episodes/*" | wc -l

# How many patterns learned?
npx claude-flow@alpha memory search --pattern "safla-xp/patterns/*/optimal" | wc -l

# Progress calculation
echo "Sessions: $(episodes count) / 10 needed for first pattern"
echo "Patterns: $(patterns count) learned so far"
```

---

## 🧪 Practice Execution Cheatsheet

### Pair Programming

**Before Session**:
1. Decide Driver/Navigator roles
2. Ensure Pair Facilitator active (auto-spawned by XP Coordinator)
3. Start task naturally

**During Session**:
- Work naturally (system monitors automatically)
- Respond to rotation prompts when appropriate
- Override recommendations if needed (system learns from outcomes)

**After Session**:
- Complete 2-minute satisfaction survey
- Review session metrics (optional)
- Trust learned optimizations

### TDD Cycle

**RED Phase**:
- Write failing test FIRST (behavior-focused)
- Wait for TDD Coordinator strategy recommendation
- Ensure test fails with meaningful error

**GREEN Phase**:
- Apply recommended strategy (Fake It/Obvious/Triangulation)
- Accept shameless green (hardcoding OK)
- Get tests passing quickly

**REFACTOR Phase**:
- Follow learned step size guidance
- Apply flocking rules systematically
- Commit after each micro-step

### Micro-Refactoring

**Before Refactoring**:
- Check coverage level (system adjusts step sizes)
- Review learned safe step sizes for your coverage
- Plan micro-steps

**During Refactoring**:
- Follow step size guidance (<10 lines for <70% coverage)
- Apply flocking rules (system recommends sequences)
- Keep tests green throughout

**After Each Step**:
- Run tests (`bin/rake test:critical`)
- Commit if green
- Continue to next micro-step

---

## 💬 Satisfaction Survey Template

### Quick 2-Minute Survey

**After Pair Programming**:
```yaml
session_id: "___"  # Provided by system
overall_effectiveness: ___/5
rotation_timing: ___/5
collaboration_quality: ___/5
would_repeat: ___/5
improvements: "___"
```

**After TDD Cycle**:
```yaml
session_id: "___"
strategy_appropriateness: ___/5
cycle_pace: ___/5
test_quality_confidence: ___/5
learning_value: ___/5
improvements: "___"
```

### Submit Survey

```bash
# Create survey JSON file (your-survey.json)
npx claude-flow@alpha memory store \
  --namespace "safla-xp/surveys/satisfaction" \
  --key "survey-$(date +%s)" \
  --value "$(cat your-survey.json)" \
  --ttl 2592000
```

---

## 🚨 Troubleshooting Quick Fixes

### Agent Not Responding

```bash
# Check agent status
npx claude-flow@alpha agent list | grep "safla"

# If not active, respawn
npx claude-flow@alpha agent spawn --type "xp-coordinator-safla"
```

### Monitoring Not Capturing Data

```bash
# Check monitoring status
npx claude-flow@alpha monitoring status

# Restart if needed
npx claude-flow@alpha monitoring restart
```

### Dashboard Not Updating

```bash
# Check metrics collection
npx claude-flow@alpha metrics status

# Restart collection
npx claude-flow@alpha metrics restart
```

### Feedback Loop Not Running

```bash
# Check workflow status
npx claude-flow@alpha workflow list | grep "SAFLA"

# Manual trigger for testing
npx claude-flow@alpha workflow execute --name "SAFLA Feedback Loop Automation"

# Check execution logs
npx claude-flow@alpha workflow logs --name "SAFLA Feedback Loop Automation"
```

---

## 📞 Escalation Paths

### Who to Contact

| Issue Type | Contact | When |
|------------|---------|------|
| **Practice Questions** | XP Coach | Need guidance on pairing/TDD/refactoring |
| **Technical Issues** | System Admin | Agents failing, monitoring down, infrastructure |
| **Documentation** | README | Need concepts, how-to, tutorial |
| **Emergency** | [Defined path] | System-wide failure |

### Quick Documentation Access

```bash
# Navigation hub
cat /docs/76-safla-neural-xp-coordination/README.md

# Technical reference
cat /docs/76-safla-neural-xp-coordination/76.01-*.md

# Deployment guide
cat /docs/76-safla-neural-xp-coordination/76.02-*.md

# Concepts explanation
cat /docs/76-safla-neural-xp-coordination/76.03-*.md

# Hands-on tutorial
cat /docs/76-safla-neural-xp-coordination/76.04-*.md
```

---

## 🎯 Daily Workflow Integration

### Morning Routine

```bash
# 1. Check system health
npx claude-flow@alpha monitoring status

# 2. Review overnight learning (feedback loop runs at 2 AM)
npx claude-flow@alpha memory search \
  --pattern "safla-xp/patterns/*/optimal" \
  --sort "validation_date DESC" \
  --limit 3

# 3. Check for new recommendations
echo "New patterns learned: [Check dashboard]"
```

### During Practice

- **Just work naturally** - system monitors automatically
- **Trust recommendations** - they're based on YOUR team's learned patterns
- **Override when needed** - system learns from ALL outcomes (successes AND overrides)

### Evening Review (Optional)

```bash
# Review today's sessions
npx claude-flow@alpha memory search \
  --pattern "safla-xp/episodes/*" \
  --timeframe "today"

# Check effectiveness scores
npx claude-flow@alpha metrics query \
  --metric "coordination_effectiveness.*" \
  --timeframe "today"

# Complete any pending satisfaction surveys
```

---

## 🔑 Key Reminders

### Do's ✅

- ✅ Work naturally, let system learn from authentic practice
- ✅ Complete satisfaction surveys (2 min after sessions)
- ✅ Trust learned optimizations (they're YOUR team's patterns)
- ✅ Override when intuition says so (system learns from overrides too)
- ✅ Celebrate improvements (review metrics weekly)

### Don'ts ❌

- ❌ Don't "perform" for the system (be authentic)
- ❌ Don't skip satisfaction surveys (they're crucial for learning)
- ❌ Don't ignore recommendations without trying (give them a chance)
- ❌ Don't expect instant results (10+ sessions needed for first pattern)
- ❌ Don't modify system configs without System Admin

---

## 📊 Pattern Recognition Indicators

### Signs System Is Learning

**Week 1-2**:
- ✅ Episodes being captured (check with queries)
- ✅ Baseline metrics established
- ⏳ Waiting for statistical significance

**Week 3-4**:
- 🎓 First "Pattern validated" message in feedback loop logs
- 🔔 Initial recommendations appearing during practice
- 📈 Dashboard shows "Pattern Recognition Speed" metric

**Week 5+**:
- 🧠 Multiple patterns active
- 🎯 Personalized strategy selection
- ⚠️ Proactive anti-pattern warnings
- 📊 Measurable effectiveness improvements

### How to Verify Learning

```bash
# Check validation log
npx claude-flow@alpha workflow logs \
  --name "SAFLA Feedback Loop Automation" | \
  grep "Pattern validated"

# Count learned patterns
npx claude-flow@alpha memory search \
  --pattern "safla-xp/patterns/*/optimal" | \
  wc -l

# View most recent pattern
npx claude-flow@alpha memory search \
  --pattern "safla-xp/patterns/*/optimal" \
  --sort "validation_date DESC" \
  --limit 1
```

---

## 🎉 Success Celebration Checkpoints

### 10 Sessions Captured
- 🎊 First pattern validation possible
- 🔍 Review learned patterns
- 📢 Share with team

### 30 Days Active
- 📊 Review effectiveness metrics
- 📈 Compare to baseline
- 🎯 Identify biggest improvements

### 90 Days Active
- 🏆 Full system assessment
- 📝 Success story documentation
- 🚀 Plan next optimization phase

---

**Print This Card**: Keep nearby during practice sessions
**Update Frequency**: Review weekly, update as system evolves
**Next Review**: Week after first pattern validation

**Questions?** Check README.md or contact XP Coach

---

**Version**: 1.0
**Last Updated**: 2025-10-01
**For**: Daily use by all team members
