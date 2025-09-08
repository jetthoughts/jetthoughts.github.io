# Contributing to JetThoughts Website

Thank you for your interest in contributing to the JetThoughts website! We welcome contributions from both team members and the community.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Contribution Types](#contribution-types)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Content Contributions](#content-contributions)

## 📜 Code of Conduct

### Our Standards

- Be respectful and inclusive
- Welcome newcomers and help them get started
- Focus on constructive criticism
- Accept responsibility and apologize for mistakes
- Prioritize what's best for the community

### Unacceptable Behavior

- Harassment, discrimination, or offensive language
- Personal attacks or trolling
- Publishing others' private information
- Any conduct that could be considered inappropriate

## 🚀 Getting Started

### Prerequisites

Before contributing, ensure you have:

1. **Development environment set up** (see [SETUP.md](docs/SETUP.md))
2. **Git configured** with your GitHub account
3. **Understanding of Hugo** basics
4. **Familiarity with the project structure**

### First-Time Contributors

1. **Find an issue** labeled `good first issue` or `help wanted`
2. **Comment on the issue** to claim it
3. **Fork the repository** to your GitHub account
4. **Create a branch** for your changes
5. **Make your changes** following our guidelines
6. **Submit a pull request**

## 💻 Development Workflow

### 1. Fork and Clone

```bash
# Fork via GitHub UI, then:
git clone https://github.com/YOUR-USERNAME/jetthoughts.github.io.git
cd jetthoughts.github.io
git remote add upstream https://github.com/jetthoughts/jetthoughts.github.io.git
```

### 2. Create a Feature Branch

```bash
# Update master
git checkout master
git pull upstream master

# Create your branch
git checkout -b feature/your-feature-name
```

### 3. Make Changes

Follow our coding standards and test your changes:

```bash
# Start development server
hugo server -D

# Run tests before committing
npm run test
```

### 4. Commit Changes

Use semantic commit messages:

```bash
git add .
git commit -m "feat: add new feature description"
```

### 5. Push and Create PR

```bash
git push origin feature/your-feature-name
# Then create PR via GitHub UI
```

## 🎯 Contribution Types

### Bug Fixes

1. **Identify the bug** - Check if it's already reported
2. **Create/claim an issue** - Describe the bug clearly
3. **Write a test** that reproduces the bug
4. **Fix the bug** - Make minimal necessary changes
5. **Verify the fix** - Ensure tests pass

### Feature Development

1. **Discuss first** - Open an issue for discussion
2. **Design the feature** - Consider UX and architecture
3. **Implement incrementally** - Break into small PRs
4. **Document the feature** - Update relevant docs
5. **Add tests** - Cover new functionality

### Documentation

1. **Identify gaps** - What's missing or unclear?
2. **Write clearly** - Use simple, direct language
3. **Include examples** - Show, don't just tell
4. **Keep it current** - Update when code changes

### Content Contributions

#### Blog Posts

For blog content, we use dev.to as the source:

1. **Join JetThoughts on dev.to**
2. **Write your article** following our style guide
3. **Tag appropriately** - First 2 tags affect URL
4. **Request review** before publishing
5. **Publish under JetThoughts** organization

#### Static Content

For pages, services, or case studies:

```bash
# Use Hugo archetypes
hugo new services/service-name/index.md
hugo new clients/client-name/index.md
```

## 📝 Coding Standards

### Hugo/HTML Guidelines

- Use semantic HTML5 elements
- Follow BEM methodology for CSS classes
- Ensure accessibility (WCAG 2.1 AA)
- Optimize images before adding
- Use Hugo shortcodes for repeated patterns

### CSS/PostCSS Standards

```css
/* Component-based organization */
.component-name { }
.component-name__element { }
.component-name--modifier { }

/* Use CSS custom properties */
:root {
  --color-primary: #333;
}
```

### JavaScript Standards

```javascript
// Use ES6+ features
const functionName = (param) => {
  // Clear, concise logic
  return result;
};

// Avoid global scope pollution
(function() {
  // Module code
})();
```

### Ruby Standards

Follow the Ruby Style Guide and use Standard gem:

```bash
# Auto-format code
bundle exec standardrb --fix
```

## 🧪 Testing Guidelines

### Required Tests

All changes must include appropriate tests:

#### For Bug Fixes
- Test that reproduces the bug
- Test that verifies the fix

#### For Features
- Unit tests for logic
- Integration tests for workflows
- Visual regression tests for UI changes

### Running Tests

```bash
# Full test suite
npm run test

# Specific tests
ruby test/test_blog_sync.rb
ruby test/test_system.rb

# Visual regression
ruby test/test_homepage.rb
```

### Writing Tests

```ruby
# Example test structure
class TestFeatureName < Minitest::Test
  def setup
    # Test setup
  end

  def test_specific_behavior
    # Arrange
    input = prepare_input
    
    # Act
    result = perform_action(input)
    
    # Assert
    assert_equal expected, result
  end
end
```

## 📦 Commit Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/):

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Formatting, missing semicolons, etc.
- **refactor**: Code restructuring
- **test**: Adding tests
- **chore**: Maintenance tasks

### Examples

```bash
feat(blog): add author bio section
fix(nav): correct dropdown menu z-index issue
docs: update README with new setup instructions
style(css): format with prettier
refactor(sync): improve dev.to API error handling
test(homepage): add mobile viewport tests
chore(deps): update Hugo to 0.147.9
```

## 🔄 Pull Request Process

### Before Submitting

- [ ] Tests pass locally (`npm run test`)
- [ ] Code follows style guidelines
- [ ] Documentation is updated
- [ ] Commit messages follow convention
- [ ] Branch is up to date with master

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement

## Testing
- [ ] Unit tests pass
- [ ] Visual regression tests pass
- [ ] Manual testing completed

## Screenshots
(if applicable)

## Related Issues
Closes #123
```

### Review Process

1. **Automated checks** - CI/CD must pass
2. **Code review** - At least one approval required
3. **Testing verification** - Reviewer tests changes
4. **Merge** - Squash and merge to master

### After Merge

- Delete your feature branch
- Update your local master
- Celebrate your contribution! 🎉

## 📚 Content Contributions

### Blog Post Guidelines

#### Style Guide
- **Tone**: Professional yet approachable
- **Length**: 800-2000 words typically
- **Structure**: Clear introduction, body, conclusion
- **Code**: Include practical examples
- **Images**: Use diagrams and screenshots

#### Topics We Love
- Ruby on Rails best practices
- Software architecture patterns
- Team collaboration techniques
- Development workflow improvements
- Case studies and lessons learned

### Documentation Standards

#### Writing Style
- Use active voice
- Keep sentences concise
- Include code examples
- Provide context and rationale
- Link to related resources

#### Markdown Formatting
```markdown
# Main Title

## Section Header

### Subsection

**Bold** for emphasis
`code` for inline code

\```language
// Code blocks with syntax highlighting
\```

- Unordered lists
1. Ordered lists

[Link text](url)
![Alt text](image-url)
```

## 🤝 Getting Help

### Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [Project Architecture](docs/ARCHITECTURE.md)
- [Setup Guide](docs/SETUP.md)

### Communication Channels

- **GitHub Issues** - Bug reports and feature requests
- **Pull Request Comments** - Code review discussions
- **Email** - info@jetthoughts.com for general questions

## 🙏 Recognition

Contributors are recognized in:
- Release notes
- Contributors page
- Annual reports

Thank you for contributing to JetThoughts! Your efforts help us maintain a high-quality website that serves our clients and community.

---

<p align="center">
  <strong>Happy Contributing! 🚀</strong>
</p>