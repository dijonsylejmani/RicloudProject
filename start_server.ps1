function Get-ContentType($filePath) {
    $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
    switch ($ext) {
        ".html" { return "text/html" }
        ".js" { return "application/javascript" }
        ".css" { return "text/css" }
        ".json" { return "application/json" }
        ".png" { return "image/png" }
        ".jpg" { return "image/jpeg" }
        ".svg" { return "image/svg+xml" }
        ".ico" { return "image/x-icon" }
        ".wasm" { return "application/wasm" }
        default { return "application/octet-stream" }
    }
}

$path = (Resolve-Path "build/web").Path
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8080/")
$listener.Start()
Write-Host "Server started at http://localhost:8080"
Write-Host "Serving files from: $path"
Write-Host "Press Ctrl+C to stop"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response
    
    $url = $request.Url.LocalPath
    if ($url -eq "/" -or $url -eq "") {
        $url = "/index.html"
    }
    
    $filePath = Join-Path $path $url.TrimStart("/")
    
    if (Test-Path $filePath -PathType Leaf) {
        $content = [System.IO.File]::ReadAllBytes($filePath)
        $response.ContentType = Get-ContentType $filePath
        $response.ContentLength64 = $content.Length
        $response.OutputStream.Write($content, 0, $content.Length)
    } else {
        $response.StatusCode = 404
        $response.StatusDescription = "Not Found"
    }
    
    $response.Close()
}