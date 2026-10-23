# Agent Workbench

A VS Code Devcontainer setup aiming to provide a safe environment for agentic coding or assistance tasks.

The container restricts privileges, but agents can modify mounted files and access the network. Only mount repositories and data you intend agents to access.

## Quick start

Install Docker, VS Code, and the VS Code Dev Containers extension.

1. Clone this repository and open it in VS Code.
2. Run **Dev Containers: Reopen in Container** from the Command Palette.
3. Wait for the image build and post-create setup to finish, then use the container terminal or OpenAI extension.

### Work on another repository

1. Clone the target repository on your host machine.
2. Uncomment the `mounts` example in [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json). Replace the source with the host repository path and the target with a container path, such as `/my-repo`.
3. Uncomment the symlink example in [`.devcontainer/postCreate.sh`](.devcontainer/postCreate.sh), replacing `<SOME_REPO>` with the matching name, such as `my-repo`.
4. Run **Dev Containers: Rebuild Container**. The repository will be accessible through `/workspaces/agent-workbench/my-repo`.

Add the workspace symlink (for example, `/my-repo`) to this repository's `.gitignore`. Changes made through the mount affect the host repository directly.

## Contents and features

- **Environment:** Ubuntu Noble, non-root `vscode` user, and writable workspaces for Git worktrees.
- **Tools:** uv, APM, Node.js 24 via nvm, npm, Codex CLI, NVIDIA SkillSpector, `curl`, `tmux`, and `ripgrep`.
- **Security:** dropped Linux capabilities, no privilege escalation, pinned tools and installer checksums, and a seven-day npm minimum release age.
- **VS Code:** OpenAI extension, Github Copilot AI features disabled, and a workspace file.
- **Customization:** workspace bind mount and a post-create hook with examples for mounting and linking other repositories.
- **Python:** Python 3.14 configuration and a dependency-free uv project; Python is not explicitly installed by the Dockerfile.
- **Git hygiene:** ignores build artifacts, dependencies, credentials, agent state, and private mounts.
- **Agent instructions:** [`AGENTS.md`](AGENTS.md) requires checking README accuracy after every major change.

