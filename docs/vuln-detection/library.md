# Application Dependencies

`Trivy` automatically detects the following files in the container and scans vulnerabilities in the application dependencies.

- Ruby
    - Gemfile.lock
- Python
    - Pipfile.lock
    - poetry.lock
- PHP
    - composer.lock
- Node.js
    - package-lock.json (dev dependencies are excluded)
    - yarn.lock
- Rust
    - Cargo.lock
- .NET
    - packages.lock.json
- Java
    - JAR/WAR/EAR files (*.jar, *.war, and *.ear)
- Go
    - Binaries built by Go (UPX-compressed binaries don't work)
    - go.sum

The path of these files does not matter.

Example: https://github.com/aquasecurity/trivy-ci-test/blob/main/Dockerfile
