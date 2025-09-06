# Build Command Prevention Measures

## Overview

This document outlines comprehensive prevention measures to avoid breaking the build commands (`bin/dev`, `bin/test`, `bin/build`, `bin/dtest`) in the future. These measures are based on the Hugo cache configuration incident that occurred and lessons learned from the debugging process.

## 1. Automated Configuration Validation

### Pre-commit Hook for Hugo Configuration
```bash
#!/bin/bash
# File: .git/hooks/pre-commit
# Validate Hugo configuration before commits

echo "🔍 Validating Hugo configuration..."

# Test Hugo configuration syntax
if ! hugo config --quiet >/dev/null 2>&1; then
    echo "❌ Hugo configuration is invalid!"
    hugo config 2>&1 | grep -E "(Error|error)"
    echo "Fix configuration errors before committing."
    exit 1
fi

# Validate cache configuration against known valid cache names
VALID_CACHES=("assets" "getcsv" "getjson" "getresource" "images" "misc" "modules")
INVALID_CACHES=()

# Extract cache names from hugo.toml
if [[ -f "hugo.toml" ]]; then
    while IFS= read -r line; do
        if [[ $line =~ ^\[caches\.([^]]+)\] ]]; then
            cache_name="${BASH_REMATCH[1]}"
            if [[ ! " ${VALID_CACHES[*]} " =~ " $cache_name " ]]; then
                INVALID_CACHES+=("$cache_name")
            fi
        fi
    done < hugo.toml
    
    if [[ ${#INVALID_CACHES[@]} -gt 0 ]]; then
        echo "❌ Invalid Hugo cache names detected:"
        printf '   - %s\n' "${INVALID_CACHES[@]}"
        echo "Valid cache names: ${VALID_CACHES[*]}"
        exit 1
    fi
fi

echo "✅ Hugo configuration validation passed"
```

### GitHub Actions Configuration Check
```yaml
# File: .github/workflows/config-validation.yml
name: Configuration Validation
on:
  pull_request:
    paths:
      - 'hugo.toml'
      - 'hugo.*.toml'
      - 'config/**'

jobs:
  validate-config:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: 'latest'
          extended: true
      
      - name: Validate Hugo Configuration
        run: |
          hugo config --quiet
          echo "✅ Hugo configuration is valid"
          
      - name: Test Build Commands
        run: |
          # Test that Hugo can build without errors
          timeout 60 hugo build --quiet --renderToMemory
          echo "✅ Hugo build test passed"
```

## 2. Configuration Documentation and Standards

### Hugo Cache Configuration Reference
Create comprehensive documentation for allowed configurations:

```toml
# Valid Hugo Cache Types - REFERENCE
# Only use these cache types in [caches] section:
#
# assets     - CSS, JS, and other asset files
# getcsv     - Data from getCSV function calls
# getjson    - Data from getJSON function calls  
# getresource - Remote resources fetched with resources.GetRemote
# images     - Processed images
# misc       - Miscellaneous cache items
# modules    - Hugo modules and dependencies
#
# INVALID CACHE TYPES (DO NOT USE):
# templates  - Not a valid Hugo cache type
# layouts    - Not a valid Hugo cache type
# content    - Not a valid Hugo cache type
```

### Configuration Change Protocol
1. **Always validate locally** before pushing changes to hugo.toml
2. **Run test suite** after any configuration changes
3. **Document the reason** for configuration changes in commit messages
4. **Test in staging** before deploying to production

## 3. Development Workflow Integration

### Local Development Checklist
Before making configuration changes:
- [ ] Run `hugo config` to validate syntax
- [ ] Run `hugo build --quiet --renderToMemory` to test build
- [ ] Run `bin/dev` to ensure development server starts
- [ ] Run `bin/test` to ensure test suite works
- [ ] Check for any warnings or errors in output

### IDE/Editor Integration
#### VS Code Configuration
```json
{
  "files.associations": {
    "hugo.toml": "toml",
    "hugo.*.toml": "toml"
  },
  "yaml.schemas": {
    "https://raw.githubusercontent.com/gohugoio/hugo/master/docs/content/en/functions/hugo.md": "hugo.toml"
  }
}
```

## 4. Monitoring and Alerting

### Build Status Monitoring
```bash
#!/bin/bash
# File: scripts/health-check.sh
# Regular health check script for all build commands

COMMANDS=("bin/dev" "bin/test" "bin/build" "bin/dtest")
FAILED_COMMANDS=()

for cmd in "${COMMANDS[@]}"; do
    echo "🧪 Testing $cmd..."
    
    case $cmd in
        "bin/dev")
            # Test dev server can start (with timeout)
            timeout 30 $cmd > /dev/null 2>&1
            if [[ $? -ne 124 ]]; then  # 124 is timeout exit code
                FAILED_COMMANDS+=("$cmd")
            fi
            ;;
        "bin/test")
            # Run quick test suite validation
            timeout 60 $cmd --version > /dev/null 2>&1
            if [[ $? -ne 0 ]]; then
                FAILED_COMMANDS+=("$cmd")
            fi
            ;;
        *)
            # For other commands, check they can start
            timeout 30 $cmd --help > /dev/null 2>&1
            if [[ $? -ne 0 ]] && [[ $? -ne 124 ]]; then
                FAILED_COMMANDS+=("$cmd")
            fi
            ;;
    esac
done

if [[ ${#FAILED_COMMANDS[@]} -gt 0 ]]; then
    echo "❌ Failed commands:"
    printf '   - %s\n' "${FAILED_COMMANDS[@]}"
    exit 1
else
    echo "✅ All build commands healthy"
fi
```

## 5. Emergency Response Procedures

### Quick Diagnostic Commands
When build commands fail, run these diagnostic steps:

```bash
# 1. Check Hugo configuration
echo "=== HUGO CONFIG TEST ==="
hugo config 2>&1 | head -20

# 2. Check for syntax errors
echo "=== HUGO SYNTAX TEST ==="
hugo build --quiet --renderToMemory 2>&1 | grep -E "(Error|error|ERROR)"

# 3. Check file permissions
echo "=== PERMISSION TEST ==="
ls -la bin/

# 4. Check Docker status (for dtest)
echo "=== DOCKER TEST ==="
docker --version && docker compose version

# 5. Check Ruby/Bundle status (for test)
echo "=== RUBY TEST ==="
bundle --version && ruby --version
```

### Rollback Procedures
```bash
#!/bin/bash
# File: scripts/emergency-rollback.sh
# Emergency rollback for broken configuration

echo "🚨 Starting emergency rollback..."

# 1. Backup current broken config
cp hugo.toml hugo.toml.broken.$(date +%s)
echo "✅ Backed up broken config"

# 2. Restore from last known good state
if [[ -f "hugo.toml.backup" ]]; then
    cp hugo.toml.backup hugo.toml
    echo "✅ Restored from backup"
elif git rev-parse --verify HEAD~1 > /dev/null 2>&1; then
    git checkout HEAD~1 -- hugo.toml
    echo "✅ Restored from Git history"
else
    echo "❌ No backup available, manual recovery needed"
    exit 1
fi

# 3. Validate restoration
if hugo config --quiet > /dev/null 2>&1; then
    echo "✅ Rollback successful - configuration is valid"
else
    echo "❌ Rollback failed - configuration still invalid"
    exit 1
fi
```

## 6. Knowledge Management

### Common Issues Database
Document all configuration issues encountered:

| Issue | Symptoms | Root Cause | Solution | Prevention |
|-------|----------|------------|----------|------------|
| Invalid cache type | Hugo build fails with cache error | Invalid cache name in hugo.toml | Remove invalid cache types | Pre-commit validation |
| Permission errors | bin/ commands fail | File permissions changed | chmod +x bin/* | File permission monitoring |
| Docker issues | dtest fails | Docker daemon down | Start Docker | Docker health check |

### Team Training Materials
- **Hugo Configuration Guide**: Document all valid configuration options
- **Debugging Playbook**: Step-by-step troubleshooting guide
- **Emergency Contacts**: Who to contact for different types of failures

## 7. Automated Recovery

### Self-Healing Configuration
```bash
#!/bin/bash
# File: scripts/auto-heal.sh
# Automatic recovery for common issues

# Detect and fix common problems
if ! hugo config --quiet > /dev/null 2>&1; then
    echo "🔧 Detected Hugo configuration issue, attempting auto-fix..."
    
    # Remove known problematic cache types
    sed -i.bak '/\[caches\.templates\]/,/^$/d' hugo.toml
    sed -i.bak '/\[caches\.layouts\]/,/^$/d' hugo.toml
    sed -i.bak '/\[caches\.content\]/,/^$/d' hugo.toml
    
    if hugo config --quiet > /dev/null 2>&1; then
        echo "✅ Auto-fix successful"
    else
        echo "❌ Auto-fix failed, manual intervention needed"
        # Restore backup
        mv hugo.toml.bak hugo.toml
        exit 1
    fi
fi
```

## Implementation Priority

1. **High Priority (Implement Immediately)**:
   - Pre-commit hook for configuration validation
   - Local development checklist
   - Emergency rollback procedures

2. **Medium Priority (Implement Within 1 Week)**:
   - GitHub Actions configuration validation
   - Build status monitoring script
   - Documentation updates

3. **Low Priority (Implement Within 1 Month)**:
   - IDE integration
   - Automated recovery scripts
   - Comprehensive team training

## Maintenance

- **Monthly Review**: Check and update prevention measures
- **Quarterly Audit**: Test all emergency procedures
- **After Each Incident**: Update prevention measures based on lessons learned

This prevention framework ensures robust protection against future build command failures while maintaining development velocity.