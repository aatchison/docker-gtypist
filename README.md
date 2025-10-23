# docker-gtypist
GNU Typist built and run in a container

## Features

- Automatically builds the latest version of gtypist from GNU FTP
- Optimized multi-stage build for smaller image size
- Runs as non-root user for security
- Supports multiple architectures (amd64, arm/v7, arm64)

## Usage

### Run with the latest version

```bash
docker run -it ghcr.io/aatchison/docker-gtypist:latest
```

### Run a specific gtypist version

```bash
# Run gtypist version 2.10.1
docker run -it ghcr.io/aatchison/docker-gtypist:2.10.1
```

### Run the latest main branch build

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

## Image Tags

The following tags are available:

- `latest` - Latest build from main branch with the newest gtypist version
- `main` - Latest build from main branch
- `X.Y.Z` - Specific gtypist version (e.g., `2.10.1`)
- `sha-XXXXXXX` - Specific commit SHA

## Automated Builds

This repository uses GitHub Actions to:
- **Nightly builds**: Check for new gtypist versions and build only if updated
- **Push to main**: Build and publish with version-specific tags
- **Pull requests**: Test builds without publishing
- **Skip redundant builds**: If gtypist version hasn't changed, scheduled builds are skipped
