FROM ubuntu:26.04

LABEL org.opencontainers.image.authors="estebanborai@gmail.com"
LABEL description="Developer-Kit Container"
LABEL version="1.0"

RUN apt-get update && apt-get install -y \
    bat \
    build-essential \
    ca-certificates \
    cargo \
    curl \
    fd-find \
    git \
    htop \
    jq \
    nodejs \
    npm \
    python3 \
    python3-pip \
    ripgrep \
    sudo \
    tree \
    unzip \
    && rm -rf "/var/lib/apt/lists/*"

# Update Packages
RUN apt-get update

# Install Bun.sh
RUN npm install -g bun

# Install Claude Code
RUN npm install -g @anthropic-ai/claude-code

# Install GitHub Copilot CLI
RUN npm install -g @github/copilot

# Install UV
RUN pip install --break-system-packages uv

# Install Spec-Kit
RUN uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# Install Starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes
RUN echo 'eval "$(/usr/local/bin/starship init bash)"' >> /home/ubuntu/.bashrc

ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupmod --gid $USER_GID $USERNAME \
    && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME

RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir -p /workspaces/dev

WORKDIR /workspaces/dev

USER $USERNAME

CMD ["bash"]
