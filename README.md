# Agent Workbench

A VS Code Devcontainer setup aiming to provide a safe environment for agentic coding or assistance tasks.

The container restricts privileges, but agents can modify mounted files and access the network. Only mount repositories and data you intend agents to access.

## Quick start

Install Docker, VS Code, and the VS Code Dev Containers extension.

1. Clone this repository and open it in VS Code.
2. Run **Dev Containers: Reopen in Container** from the Command Palette.
3. Wait for the image build to finish, then use the container terminal or OpenAI extension.

### Work with repositories or other folders

Workspace folders do not need to be Git repositories. You can also mount a knowledge vault such as an Obsidian vault, a notes directory, or any other folder. The `repos/` directory is just a location for mounts; its name does not restrict their contents.

1. Choose an existing folder on your host machine, or clone a repository there.
2. Uncomment the `mounts` example in [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json). Replace the source with the host folder path and the target with `/workspaces/agent-workbench/repos/my-folder`, using your folder's name. Add a mount entry for each folder you want to use.
3. Run **Dev Containers: Rebuild Container**. Each folder will be accessible at its configured mount path.
4. In [`.devcontainer/agent-workbench.code-workspace`](.devcontainer/agent-workbench.code-workspace), uncomment the folder placeholder, give it a name, and replace `../repos/<...>` with `../repos/my-folder`. Repeat the entry for each additional folder.
5. Open that workspace file inside the container using **File → Open Workspace from File…**. **Workbench** and each configured folder appear as separate top-level workspace folders. Git repositories also have independent entries in Source Control. Reopening the container alone opens the workbench directory, so open the workspace file explicitly to use this layout.

The `/repos/` directory is ignored by this repository's Git configuration. Mounted Git repositories retain their own Git history. Changes made through any mount affect the host files directly.

## Contents and features

- **Environment:** Ubuntu Noble, non-root `vscode` user, and writable workspaces for Git worktrees.
- **Tools:** uv, APM, Node.js 24 via nvm, npm, Codex CLI, NVIDIA SkillSpector, `curl`, `tmux`, and `ripgrep`.
- **Security:** dropped Linux capabilities, no privilege escalation, pinned tools and installer checksums, and a seven-day npm minimum release age.
- **VS Code:** OpenAI extension, Github Copilot AI features disabled, and a workspace file.
- **Customization:** workspace bind mount and an example for mounting repositories, knowledge vaults, or other folders directly under `repos/`.
- **Python:** Python 3.14 configuration and a dependency-free uv project; Python is not explicitly installed by the Dockerfile.
- **Git hygiene:** ignores build artifacts, dependencies, credentials, agent state, and private mounts.
- **Agent instructions:** [`AGENTS.md`](AGENTS.md) requires checking README accuracy after every major change.

