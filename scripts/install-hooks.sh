#!/usr/bin/env bash
#
# Install the side-door git hooks for this clone.
# Run once after cloning.
#

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

# Point git at our tracked hooks dir
git config core.hooksPath scripts/git-hooks
# Make sure the hook is executable
chmod +x scripts/git-hooks/pre-commit

echo "Installed. Hooks live in scripts/git-hooks/ and run on every commit."
echo "To uninstall: git config --unset core.hooksPath"
