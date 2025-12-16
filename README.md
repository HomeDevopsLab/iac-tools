# IAC Tools Docker Image

A Docker image containing essential Infrastructure as Code (IAC) tools for automating infrastructure management and deployment.

## Overview

This Docker image is based on Ubuntu 24.04 and includes popular IAC tools commonly used in DevOps workflows:

- **Terraform** - Infrastructure provisioning tool
- **Terragrunt** - Terraform wrapper for managing multiple environments
- **Ansible** - Configuration management and automation tool
- **Vault** - Hashicorp vault binary

## Included Tools

| Tool       | Version  | Description                                                                                      |
| ---------- | -------- | ------------------------------------------------------------------------------------------------ |
| Terraform  | 1.11.4   | Infrastructure as Code tool for building, changing, and versioning infrastructure                |
| Terragrunt | v0.77.22 | Thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules |
| Ansible    | Latest   | Automation platform for configuration management, application deployment, and task automation    |
| vault      | Latest   | Hashicorp vault client for managing vault resources                                              |

## Additional Packages

- Git - Version control system
- Curl - Command line tool for transferring data
- Wget - Commandline tool for downloading data
- GPG - Data encryption
- JQ - Command line JSON processor
- Unzip - Archive extraction utility
- Pipx - Tool for installing and running Python applications in isolated environments

## Usage

### Pull the image

```bash
# From Docker Hub (after CI/CD setup)
docker pull <your-dockerhub-username>/iac-tools:latest

# Or build locally
docker build -t iac-tools:latest .
```

### Run the container

```bash
# Interactive shell
docker run -it --rm iac-tools:latest /bin/bash

# Mount your workspace
docker run -it --rm -v $(pwd):/workspace -w /workspace iac-tools:latest /bin/bash

# Run specific commands
docker run --rm -v $(pwd):/workspace -w /workspace iac-tools:latest terraform --version
docker run --rm -v $(pwd):/workspace -w /workspace iac-tools:latest terragrunt --version
docker run --rm -v $(pwd):/workspace -w /workspace iac-tools:latest ansible --version
```

### Docker Compose

You can also use this image with Docker Compose:

```yaml
version: "3.8"
services:
  iac-tools:
    image: iac-tools:latest
    volumes:
      - .:/workspace
    working_dir: /workspace
    stdin_open: true
    tty: true
```

## Building the Image

### Local Build
To build the image locally:

```bash
docker build -t iac-tools:latest .
```

### Automated CI/CD
This repository includes a GitHub Actions workflow that automatically:
- Builds multi-platform Docker images (amd64/arm64) on every push
- Tests all included tools (Terraform, Terragrunt, Ansible, Git)
- Performs security vulnerability scanning
- Publishes to Docker Hub on main branch and tags

See [GITHUB_ACTIONS_SETUP.md](GITHUB_ACTIONS_SETUP.md) for detailed setup instructions.

## Environment Variables

- `DEBIAN_FRONTEND=noninteractive` - Prevents interactive prompts during package installation
- `TERRAGRUNT_VERSION=v0.77.22` - Specifies the Terragrunt version to install
- `TF_VERSION=1.11.4` - Specifies the Terraform version to install
- `ARCH=amd64` - Target architecture
- `OS=linux` - Target operating system
- `PATH` - Includes `/root/.local/bin` for pipx-installed tools

## Use Cases

This image is ideal for:

- CI/CD pipelines requiring infrastructure automation
- Development environments for IAC workflows
- Consistent tooling across different environments
- Containerized infrastructure deployments
- Learning and experimenting with IAC tools

## Security

- The image runs as root user (default for this use case)
- Base image is Ubuntu 24.04 with latest security updates
- Only essential packages are installed to minimize attack surface

## Maintenance

- **Maintainer**: Krzysztof Królikowski <kkrolikowski@gmail.com>
- **Version**: 1.0
- **Base Image**: Ubuntu 24.04

## License

See the [LICENSE](LICENSE) file for license information.

## Contributing

Feel free to submit issues and enhancement requests!
