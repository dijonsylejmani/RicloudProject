$path = Resolve-Path "flutter.zip"
$dest = Resolve-Path "."
Expand-Archive -Path $path.Path -DestinationPath $dest.Path -Force -Verbose
Write-Host "Extraction completed"