# Use the same base image
FROM mcr.microsoft.com/devcontainers/base:noble

ARG USERNAME=vscode

# UV
ARG UV_VERSION=0.12.0
ARG UV_SHA256_CHECKSUM=b67e385074fddc9b99cd152b838fd91046d9fbc261b2c45f448a983ad23b8764

# APM
ARG APM_VERSION=v0.35.0
ARG APM_INSTALLER_COMMIT=6a826cfa812be8d71f77c4206f11d5b17df42dcc
ARG APM_SHA256_CHECKSUM=0e813353630c02a9eb961fbad82cf916967e855aa84a533940975c5d699c9caa

# NODE + NVM
ARG NODE_VERSION=24
ARG NVM_VERSION=0.40.4
ARG NVM_INSTALL_SHA256=4b7412c49960c7d31e8df72da90c1fb5b8cccb419ac99537b737028d497aba4f

# Codex
ARG CODEX_VERSION=0.163.0

# Nvidia SkillSpector
ARG NVIDIA_SKILL_SPECTOR_COMMIT=d7338f58200a9ae2a24810cee08911ab68b107a7

ENV DEBIAN_FRONTEND=noninteractive
ENV NVM_DIR=/home/${USERNAME}/.nvm
ENV PATH=${NVM_DIR}/versions/node/v${NODE_VERSION}/bin:${PATH}
ENV PATH=/home/${USERNAME}/.local/bin:${PATH}

USER root

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        tmux \
        ripgrep \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add uv
ARG UV_INSTALL_SCRIPT_NAME=uv_install.sh
RUN curl -LsSf https://astral.sh/uv/${UV_VERSION}/install.sh -o ${UV_INSTALL_SCRIPT_NAME} \
    && echo "${UV_SHA256_CHECKSUM} ${UV_INSTALL_SCRIPT_NAME}" | sha256sum -c \
    && UV_INSTALL_DIR=/usr/local/bin UV_NO_MODIFY_PATH=1 sh ${UV_INSTALL_SCRIPT_NAME} \
    && rm ${UV_INSTALL_SCRIPT_NAME} \
    && uv --version

# Pre-create the workspaces directory (before VSCode devcontainers) and set permissions, to allow to generate worktrees, which live inside the /workspaces folder
RUN mkdir -p /workspaces \
    && chown -R ${USERNAME}:${USERNAME} /workspaces

# Non-root user
USER ${USERNAME}

# Add apm
ARG APM_INSTALL_SCRIPT_PATH=/tmp/apm_install.sh
RUN curl -LsSf \
        "https://raw.githubusercontent.com/microsoft/apm/${APM_INSTALLER_COMMIT}/install.sh" \
        -o ${APM_INSTALL_SCRIPT_PATH} \
    && echo "${APM_SHA256_CHECKSUM} ${APM_INSTALL_SCRIPT_PATH}" | sha256sum -c \
    && VERSION="${APM_VERSION}" \
        APM_NO_MODIFY_PATH=1 \
        sh ${APM_INSTALL_SCRIPT_PATH} \
    && rm ${APM_INSTALL_SCRIPT_PATH} \
    && apm --version

# Add nvm and node
RUN set -ex; \
    curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" -o /tmp/install-nvm.sh; \
    echo "${NVM_INSTALL_SHA256}  /tmp/install-nvm.sh" | sha256sum -c -; \
    mkdir -p "${NVM_DIR}"; \
    bash /tmp/install-nvm.sh; \
    . "${NVM_DIR}/nvm.sh"; \
    nvm install "${NODE_VERSION}"; \
    nvm alias default "${NODE_VERSION}"; \
    nvm use default; \
    echo "Node version: $(node -v)"; \
    echo "NPM version: $(npm -v)"; \
    npm config set min-release-age 7; \
    npm config ls --long | grep before; \
    rm /tmp/install-nvm.sh

# Add Codex CLI
RUN set -ex; \
    . "${NVM_DIR}/nvm.sh"; \
    npm i -g "@openai/codex@${CODEX_VERSION}"; \
    codex --version

# Add SkillInspector by Nvidia
# See https://github.com/NVIDIA/SkillSpector
RUN uv tool install "git+https://github.com/NVIDIA/skillspector.git@${NVIDIA_SKILL_SPECTOR_COMMIT}"
