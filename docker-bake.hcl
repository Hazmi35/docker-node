variable "REGISTRY" {
  default = ["docker.io/hazmi35", "ghcr.io/hazmi35"]
}

variable "METADATA_TAGS" {
  default = ""
}

variable "METADATA_LABELS" {
  default = ""
}

variable "PUSH" {
  default = false
}

# 24/alpine
target "24-alpine" {
  context    = "./24/alpine"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/s390x"]
  tags       = formatlist("%s/node:%s", REGISTRY, ["24-alpine","24.15.0-alpine","24.15-alpine","lts-alpine","krypton-alpine"])
  labels     = split(",", METADATA_LABELS)
  push       = PUSH
}

# 24/debian
target "24-debian" {
  context    = "./24/debian"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/ppc64le", "linux/s390x"]
  tags       = formatlist("%s/node:%s", REGISTRY, ["24","24.15.0","24.15","lts","krypton"])
  labels     = split(",", METADATA_LABELS)
  push       = PUSH
}

# 24/dev/alpine
target "24-dev-alpine" {
  context    = "./24/dev/alpine"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/s390x"]
  tags       = formatlist("%s/node:%s", REGISTRY, ["24-dev-alpine","24.15.0-dev-alpine","24.15-dev-alpine","lts-dev-alpine","krypton-dev-alpine"])
  labels     = split(",", METADATA_LABELS)
  push       = PUSH
}

# 24/dev/debian
target "24-dev-debian" {
  context    = "./24/dev/debian"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/ppc64le", "linux/s390x"]
  tags       = formatlist("%s/node:%s", REGISTRY, ["24-dev","24.15.0-dev","24.15-dev","lts-dev","krypton-dev"])
  labels     = split(",", METADATA_LABELS)
  push       = PUSH
}

# 22/alpine
target "22-alpine" {
  context    = "./22/alpine"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/arm/v7", "linux/arm/v6", "linux/s390x"]
  tags       = formatlist("%s/node:%s", REGISTRY, ["22-alpine","22.22.2-alpine","22.22-alpine","jod-alpine","oldlts-alpine"])
  labels     = split(",", METADATA_LABELS)
  push       = PUSH
}

# 22/debian
target "22-debian" {
  context    = "./22/debian"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/arm/v7", "linux/ppc64le", "linux/s390x"]
  tags       = formatlist("%s/node:%s", REGISTRY, ["22","22.22.2","22.22","jod","oldlts"])
  labels     = split(",", METADATA_LABELS)
  push       = PUSH
}

# 22/dev/alpine
target "22-dev-alpine" {
  context    = "./22/dev/alpine"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/arm/v7", "linux/arm/v6", "linux/s390x"]
  tags       = formatlist("%s/node:%s", REGISTRY, ["22-dev-alpine","22.22.2-dev-alpine","22.22-dev-alpine","jod-dev-alpine","oldlts-dev-alpine"])
  labels     = split(",", METADATA_LABELS)
  push       = PUSH
}

# 22/dev/debian
target "22-dev-debian" {
  context    = "./22/dev/debian"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/arm/v7", "linux/ppc64le", "linux/s390x"]
  tags       = formatlist("%s/node:%s", REGISTRY, ["22-dev","22.22.2-dev","22.22-dev","jod-dev","oldlts-dev"])
  labels     = split(",", METADATA_LABELS)
  push       = PUSH
}

# 25/alpine
target "25-alpine" {
  context    = "./25/alpine"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/s390x"]
  tags       = formatlist("%s/node:%s", REGISTRY, ["25-alpine","25.9.0-alpine","25.9-alpine","current-alpine","latest-alpine"])
  labels     = split(",", METADATA_LABELS)
  push       = PUSH
}

# 25/debian
target "25-debian" {
  context    = "./25/debian"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/ppc64le", "linux/s390x"]
  tags       = formatlist("%s/node:%s", REGISTRY, ["25","25.9.0","25.9","current","latest"])
  labels     = split(",", METADATA_LABELS)
  push       = PUSH
}

# 25/dev/alpine
target "25-dev-alpine" {
  context    = "./25/dev/alpine"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/s390x"]
  tags       = formatlist("%s/node:%s", REGISTRY, ["25-dev-alpine","25.9.0-dev-alpine","25.9-dev-alpine","current-dev-alpine","latest-dev-alpine"])
  labels     = split(",", METADATA_LABELS)
  push       = PUSH
}

# 25/dev/debian
target "25-dev-debian" {
  context    = "./25/dev/debian"
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64/v8", "linux/ppc64le", "linux/s390x"]
  tags       = formatlist("%s/node:%s", REGISTRY, ["25-dev","25.9.0-dev","25.9-dev","current-dev","latest-dev"])
  labels     = split(",", METADATA_LABELS)
  push       = PUSH
}


# Groups by Node.js version
group "node-24" {
  targets = [24-alpine, 24-debian, 24-dev-alpine, 24-dev-debian]
}

group "node-22" {
  targets = [22-alpine, 22-debian, 22-dev-alpine, 22-dev-debian]
}

group "node-25" {
  targets = [25-alpine, 25-debian, 25-dev-alpine, 25-dev-debian]
}

# All targets
group "all" {
  targets = ["24-alpine", "24-debian", "24-dev-alpine", "24-dev-debian", "22-alpine", "22-debian", "22-dev-alpine", "22-dev-debian", "25-alpine", "25-debian", "25-dev-alpine", "25-dev-debian"]
}
