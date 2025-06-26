Write-Host "Running pre-up script (Windows)..."

if (Test-Path .env) {
  $gitCommit = git rev-parse --short HEAD 2>$null
  if (-not $gitCommit) { $gitCommit = "unknown" }

  (Get-Content .env) |
    ForEach-Object {
      if ($_ -match '^VITE_APP_APP_VERSION=.*') {
        "VITE_APP_APP_VERSION=$gitCommit"
      } else {
        $_
      }
    } | Set-Content .env

  Write-Host "Updated VITE_APP_APP_VERSION to $gitCommit in .env"
} else {
  Write-Host "Warning: .env file not found"
  if (Test-Path .env.example) {
    Copy-Item .env.example .env
  } else {
    Write-Host ".env.example not found. Cannot continue."
    exit 1
  }


  $gitCommit = git rev-parse --short HEAD 2>$null
  if (-not $gitCommit) { $gitCommit = "unknown" }

  (Get-Content .env) |
    ForEach-Object {
      if ($_ -match '^VITE_APP_APP_VERSION=.*') {
        "VITE_APP_APP_VERSION=$gitCommit"
      } else {
        $_
      }
    } | Set-Content .env

  Write-Host "Updated VITE_APP_APP_VERSION to $gitCommit in .env"
}
