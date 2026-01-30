# 🚀 Development-Kit Container

A containerized development environment with AI-Assisted Development.

## Overview

This Dockerfile creates a comprehensive development container based on **Ubuntu 26.04** that includes **Node.js** runtime, essential development tools, and AI-powered coding capabilities through **Claude Code**. It's designed to provide a consistent, portable development environment that works across different machines and platforms.

## Features

- **Node.js** and **npm** pre-installed
- **Claude Code** integration for AI-assisted coding
- Other essential tools: `git`, `htop`, `jq`, `python3`, and more
- Support for installation of additional packages with `sudo`
- Optimized image size with apt cache clean-up

## Requirements

- **Docker** or compatible container runtime

## Usage

### Docker Container

Build and run the container:

```bash
docker build . -t dkc && \
  docker run -d --name dkc-lab dkc tail -f /dev/null && \
  docker exec -it dkc-lab bash
```

> Provide a `name` for easy reference. You can run multiple containers simultaneously for different AI agents.

#### Teardown

To remove the container and image:

```bash
docker rm -f dkc-lab && docker image rm dkc
```

> **Warning:** This action cannot be undone.

### Docker Compose

Add the following `docker-compose.dev.yml` to your project:

```yml
services:
  claude:
    image: 'ghcr.io/leoborai/dkc:latest'
    volumes:
      - ../:/workspaces/dev
    command: tail -f /dev/null # avoid using CPU to keep the container alive
```

Run the Docker Compose file:

```bash
docker compose -f ./dev/docker-compose.dev.yml up --build --detach
```

Finally, `exec` into the running container:

```bash
docker exec -it <container_id> bash
```

## Notes

- The container runs as a non-root user for security.
- All development tools are pre-installed and ready to use.
- The image is optimized for size by cleaning the apt cache after installation.
- Sudo access is available for installing additional packages if needed.
