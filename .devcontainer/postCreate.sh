#!/bin/env bash
set -euo pipefail

# Symlink to <SOME_REPO>; Host -> Bind mount -> /<SOME_REPO> inside devcontainer -> Symlink -> inside workspace folder
# if [ ! -L /workspaces/agent-workbench/<SOME_REPO> ]; then
#     ln -s /<SOME_REPO> /workspaces/agent-workbench/<SOME_REPO>
# fi