# docker-gtypist
GNU Typist built and run in a container

## Features

- Automatically builds the latest version of gtypist from GNU FTP
- Optimized multi-stage build for smaller image size
- Runs as non-root user for security
- Supports multiple architectures (amd64, arm/v7, arm64)

## Usage

### Run with the latest version (default)

```bash
docker run -it ghcr.io/aatchison/docker-gtypist:main
```

### Build locally

```bash
# Build with the latest version (fetched automatically)
docker build -t gtypist .

# Build with a specific version
docker build --build-arg GTYPIST_VERSION=2.10.1 -t gtypist .
```

## Build Arguments

- `GTYPIST_VERSION`: Specify the gtypist version to build (default: `latest`)
  - Set to `latest` to automatically fetch and build the newest version
  - Set to a specific version number (e.g., `2.10.1`) to pin to that version

## Automated Builds

This repository uses GitHub Actions to:
- Build and publish images nightly with the latest gtypist version
- Build on every push to main branch
- Test builds on pull requests
