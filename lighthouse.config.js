// Simple Lighthouse configuration
module.exports = {
  ci: {
    assert: {
      assertions: {
        'categories:performance': ['error', {minScore: 90}],
        'categories:accessibility': ['error', {minScore: 90}],
        'categories:best-practices': ['error', {minScore: 90}]
      }
    }
  }
};