$ErrorActionPreference = "Stop"

$tagInfo = git describe --tags --dirty --always
$version = $tagInfo -replace '^v', ''
$revision = git rev-parse --short HEAD
$buildDate = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$imageName = "mdzio/rm-build-env"

Write-Host "Building Docker image..."
Write-Host "  Version: $version"
Write-Host "  Revision: $revision"
Write-Host "  Build date: $buildDate"

docker build . `
  --tag "${imageName}:$version" `
  --tag "${imageName}:latest" `
  --label "org.opencontainers.image.version=$version" `
  --label "org.opencontainers.image.revision=$revision" `
  --label "org.opencontainers.image.created=$buildDate"
