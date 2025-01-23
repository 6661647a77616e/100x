search queries automation 
```powershell
$query = 'inurl:admin intitle:"login"'
$url = "https://google.com/search?q=$query"
$response = Invoke-WebRequest -Uri $url
$response.Content
```

bulk searching
```powershell
$keywords = @("admin", "login", "password")
foreach ($keyword in $keywords) {
    $query = "inurl:$keyword"
    $url = "https://www.google.com/search?q=$query"
    $response = Invoke-WebRequest -Uri $url
    Write-Output "Results for $query:"
    $response.Content -match '<h3 class="r"><a href="([^"]+)"'
    $url = $matches[1]
    Write-Output "Found URL: $url"
}
```

saving results
```powershell
$response.Content | Out-File -FilePath "search_results.html"
```