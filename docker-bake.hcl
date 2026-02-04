variable "PUSH" {
  default = false
}

# 22/alpine
target "22-alpine" {
  context    = "./22/alpine"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/arm/v7", "linux/arm/v6", "linux/s390x"]
  tags       = ["docker.io/hazmi35/node:22", "docker.io/hazmi35/node:22-alpine", "docker.io/hazmi35/node:22.22.0", "docker.io/hazmi35/node:22.22.0-alpine", "docker.io/hazmi35/node:22.22", "docker.io/hazmi35/node:22.22-alpine", "docker.io/hazmi35/node:jod", "docker.io/hazmi35/node:jod-alpine", "docker.io/hazmi35/node:oldlts", "docker.io/hazmi35/node:oldlts-alpine", "ghcr.io/hazmi35/node:22", "ghcr.io/hazmi35/node:22-alpine", "ghcr.io/hazmi35/node:22.22.0", "ghcr.io/hazmi35/node:22.22.0-alpine", "ghcr.io/hazmi35/node:22.22", "ghcr.io/hazmi35/node:22.22-alpine", "ghcr.io/hazmi35/node:jod", "ghcr.io/hazmi35/node:jod-alpine", "ghcr.io/hazmi35/node:oldlts", "ghcr.io/hazmi35/node:oldlts-alpine"]
  push       = PUSH
}

# 22/debian
target "22-debian" {
  context    = "./22/debian"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/arm/v7", "linux/ppc64le", "linux/s390x"]
  tags       = ["docker.io/hazmi35/node:22", "docker.io/hazmi35/node:22.22.0", "docker.io/hazmi35/node:22.22", "docker.io/hazmi35/node:jod", "docker.io/hazmi35/node:oldlts", "ghcr.io/hazmi35/node:22", "ghcr.io/hazmi35/node:22.22.0", "ghcr.io/hazmi35/node:22.22", "ghcr.io/hazmi35/node:jod", "ghcr.io/hazmi35/node:oldlts"]
  push       = PUSH
}

# 22/dev/alpine
target "22-dev-alpine" {
  context    = "./22/dev/alpine"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/arm/v7", "linux/arm/v6", "linux/s390x"]
  tags       = ["docker.io/hazmi35/node:22", "docker.io/hazmi35/node:22-dev-alpine", "docker.io/hazmi35/node:22.22.0", "docker.io/hazmi35/node:22.22.0-dev-alpine", "docker.io/hazmi35/node:22.22", "docker.io/hazmi35/node:22.22-dev-alpine", "docker.io/hazmi35/node:jod", "docker.io/hazmi35/node:jod-dev-alpine", "docker.io/hazmi35/node:oldlts", "docker.io/hazmi35/node:oldlts-dev-alpine", "ghcr.io/hazmi35/node:22", "ghcr.io/hazmi35/node:22-dev-alpine", "ghcr.io/hazmi35/node:22.22.0", "ghcr.io/hazmi35/node:22.22.0-dev-alpine", "ghcr.io/hazmi35/node:22.22", "ghcr.io/hazmi35/node:22.22-dev-alpine", "ghcr.io/hazmi35/node:jod", "ghcr.io/hazmi35/node:jod-dev-alpine", "ghcr.io/hazmi35/node:oldlts", "ghcr.io/hazmi35/node:oldlts-dev-alpine"]
  push       = PUSH
}

# 22/dev/debian
target "22-dev-debian" {
  context    = "./22/dev/debian"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/arm/v7", "linux/ppc64le", "linux/s390x"]
  tags       = ["docker.io/hazmi35/node:22", "docker.io/hazmi35/node:22-dev", "docker.io/hazmi35/node:22.22.0", "docker.io/hazmi35/node:22.22.0-dev", "docker.io/hazmi35/node:22.22", "docker.io/hazmi35/node:22.22-dev", "docker.io/hazmi35/node:jod", "docker.io/hazmi35/node:jod-dev", "docker.io/hazmi35/node:oldlts", "docker.io/hazmi35/node:oldlts-dev", "ghcr.io/hazmi35/node:22", "ghcr.io/hazmi35/node:22-dev", "ghcr.io/hazmi35/node:22.22.0", "ghcr.io/hazmi35/node:22.22.0-dev", "ghcr.io/hazmi35/node:22.22", "ghcr.io/hazmi35/node:22.22-dev", "ghcr.io/hazmi35/node:jod", "ghcr.io/hazmi35/node:jod-dev", "ghcr.io/hazmi35/node:oldlts", "ghcr.io/hazmi35/node:oldlts-dev"]
  push       = PUSH
}

# 24/alpine
target "24-alpine" {
  context    = "./24/alpine"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/s390x"]
  tags       = ["docker.io/hazmi35/node:24", "docker.io/hazmi35/node:24-alpine", "docker.io/hazmi35/node:24.13.0", "docker.io/hazmi35/node:24.13.0-alpine", "docker.io/hazmi35/node:24.13", "docker.io/hazmi35/node:24.13-alpine", "docker.io/hazmi35/node:lts", "docker.io/hazmi35/node:lts-alpine", "docker.io/hazmi35/node:krypton", "docker.io/hazmi35/node:krypton-alpine", "ghcr.io/hazmi35/node:24", "ghcr.io/hazmi35/node:24-alpine", "ghcr.io/hazmi35/node:24.13.0", "ghcr.io/hazmi35/node:24.13.0-alpine", "ghcr.io/hazmi35/node:24.13", "ghcr.io/hazmi35/node:24.13-alpine", "ghcr.io/hazmi35/node:lts", "ghcr.io/hazmi35/node:lts-alpine", "ghcr.io/hazmi35/node:krypton", "ghcr.io/hazmi35/node:krypton-alpine"]
  push       = PUSH
}

# 24/debian
target "24-debian" {
  context    = "./24/debian"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/ppc64le", "linux/s390x"]
  tags       = ["docker.io/hazmi35/node:24", "docker.io/hazmi35/node:24.13.0", "docker.io/hazmi35/node:24.13", "docker.io/hazmi35/node:lts", "docker.io/hazmi35/node:krypton", "ghcr.io/hazmi35/node:24", "ghcr.io/hazmi35/node:24.13.0", "ghcr.io/hazmi35/node:24.13", "ghcr.io/hazmi35/node:lts", "ghcr.io/hazmi35/node:krypton"]
  push       = PUSH
}

# 24/dev/alpine
target "24-dev-alpine" {
  context    = "./24/dev/alpine"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/s390x"]
  tags       = ["docker.io/hazmi35/node:24", "docker.io/hazmi35/node:24-dev-alpine", "docker.io/hazmi35/node:24.13.0", "docker.io/hazmi35/node:24.13.0-dev-alpine", "docker.io/hazmi35/node:24.13", "docker.io/hazmi35/node:24.13-dev-alpine", "docker.io/hazmi35/node:lts", "docker.io/hazmi35/node:lts-dev-alpine", "docker.io/hazmi35/node:krypton", "docker.io/hazmi35/node:krypton-dev-alpine", "ghcr.io/hazmi35/node:24", "ghcr.io/hazmi35/node:24-dev-alpine", "ghcr.io/hazmi35/node:24.13.0", "ghcr.io/hazmi35/node:24.13.0-dev-alpine", "ghcr.io/hazmi35/node:24.13", "ghcr.io/hazmi35/node:24.13-dev-alpine", "ghcr.io/hazmi35/node:lts", "ghcr.io/hazmi35/node:lts-dev-alpine", "ghcr.io/hazmi35/node:krypton", "ghcr.io/hazmi35/node:krypton-dev-alpine"]
  push       = PUSH
}

# 24/dev/debian
target "24-dev-debian" {
  context    = "./24/dev/debian"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/ppc64le", "linux/s390x"]
  tags       = ["docker.io/hazmi35/node:24", "docker.io/hazmi35/node:24-dev", "docker.io/hazmi35/node:24.13.0", "docker.io/hazmi35/node:24.13.0-dev", "docker.io/hazmi35/node:24.13", "docker.io/hazmi35/node:24.13-dev", "docker.io/hazmi35/node:lts", "docker.io/hazmi35/node:lts-dev", "docker.io/hazmi35/node:krypton", "docker.io/hazmi35/node:krypton-dev", "ghcr.io/hazmi35/node:24", "ghcr.io/hazmi35/node:24-dev", "ghcr.io/hazmi35/node:24.13.0", "ghcr.io/hazmi35/node:24.13.0-dev", "ghcr.io/hazmi35/node:24.13", "ghcr.io/hazmi35/node:24.13-dev", "ghcr.io/hazmi35/node:lts", "ghcr.io/hazmi35/node:lts-dev", "ghcr.io/hazmi35/node:krypton", "ghcr.io/hazmi35/node:krypton-dev"]
  push       = PUSH
}

# 25/alpine
target "25-alpine" {
  context    = "./25/alpine"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/s390x"]
  tags       = ["docker.io/hazmi35/node:25", "docker.io/hazmi35/node:25-alpine", "docker.io/hazmi35/node:25.6.0", "docker.io/hazmi35/node:25.6.0-alpine", "docker.io/hazmi35/node:25.6", "docker.io/hazmi35/node:25.6-alpine", "docker.io/hazmi35/node:current", "docker.io/hazmi35/node:current-alpine", "docker.io/hazmi35/node:latest", "docker.io/hazmi35/node:latest-alpine", "ghcr.io/hazmi35/node:25", "ghcr.io/hazmi35/node:25-alpine", "ghcr.io/hazmi35/node:25.6.0", "ghcr.io/hazmi35/node:25.6.0-alpine", "ghcr.io/hazmi35/node:25.6", "ghcr.io/hazmi35/node:25.6-alpine", "ghcr.io/hazmi35/node:current", "ghcr.io/hazmi35/node:current-alpine", "ghcr.io/hazmi35/node:latest", "ghcr.io/hazmi35/node:latest-alpine"]
  push       = PUSH
}

# 25/debian
target "25-debian" {
  context    = "./25/debian"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/ppc64le", "linux/s390x"]
  tags       = ["docker.io/hazmi35/node:25", "docker.io/hazmi35/node:25.6.0", "docker.io/hazmi35/node:25.6", "docker.io/hazmi35/node:current", "docker.io/hazmi35/node:latest", "ghcr.io/hazmi35/node:25", "ghcr.io/hazmi35/node:25.6.0", "ghcr.io/hazmi35/node:25.6", "ghcr.io/hazmi35/node:current", "ghcr.io/hazmi35/node:latest"]
  push       = PUSH
}

# 25/dev/alpine
target "25-dev-alpine" {
  context    = "./25/dev/alpine"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/s390x"]
  tags       = ["docker.io/hazmi35/node:25", "docker.io/hazmi35/node:25-dev-alpine", "docker.io/hazmi35/node:25.6.0", "docker.io/hazmi35/node:25.6.0-dev-alpine", "docker.io/hazmi35/node:25.6", "docker.io/hazmi35/node:25.6-dev-alpine", "docker.io/hazmi35/node:current", "docker.io/hazmi35/node:current-dev-alpine", "docker.io/hazmi35/node:latest", "docker.io/hazmi35/node:latest-dev-alpine", "ghcr.io/hazmi35/node:25", "ghcr.io/hazmi35/node:25-dev-alpine", "ghcr.io/hazmi35/node:25.6.0", "ghcr.io/hazmi35/node:25.6.0-dev-alpine", "ghcr.io/hazmi35/node:25.6", "ghcr.io/hazmi35/node:25.6-dev-alpine", "ghcr.io/hazmi35/node:current", "ghcr.io/hazmi35/node:current-dev-alpine", "ghcr.io/hazmi35/node:latest", "ghcr.io/hazmi35/node:latest-dev-alpine"]
  push       = PUSH
}

# 25/dev/debian
target "25-dev-debian" {
  context    = "./25/dev/debian"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/ppc64le", "linux/s390x"]
  tags       = ["docker.io/hazmi35/node:25", "docker.io/hazmi35/node:25-dev", "docker.io/hazmi35/node:25.6.0", "docker.io/hazmi35/node:25.6.0-dev", "docker.io/hazmi35/node:25.6", "docker.io/hazmi35/node:25.6-dev", "docker.io/hazmi35/node:current", "docker.io/hazmi35/node:current-dev", "docker.io/hazmi35/node:latest", "docker.io/hazmi35/node:latest-dev", "ghcr.io/hazmi35/node:25", "ghcr.io/hazmi35/node:25-dev", "ghcr.io/hazmi35/node:25.6.0", "ghcr.io/hazmi35/node:25.6.0-dev", "ghcr.io/hazmi35/node:25.6", "ghcr.io/hazmi35/node:25.6-dev", "ghcr.io/hazmi35/node:current", "ghcr.io/hazmi35/node:current-dev", "ghcr.io/hazmi35/node:latest", "ghcr.io/hazmi35/node:latest-dev"]
  push       = PUSH
}

# Groups by Node.js version
group "node-22" {
  targets = ["22-alpine", "22-debian", "22-dev-alpine", "22-dev-debian"]
}

group "node-24" {
  targets = ["24-alpine", "24-debian", "24-dev-alpine", "24-dev-debian"]
}

group "node-25" {
  targets = ["25-alpine", "25-debian", "25-dev-alpine", "25-dev-debian"]
}

# All targets
group "all" {
  targets = ["22-alpine", "22-debian", "22-dev-alpine", "22-dev-debian", "24-alpine", "24-debian", "24-dev-alpine", "24-dev-debian", "25-alpine", "25-debian", "25-dev-alpine", "25-dev-debian"]
}
