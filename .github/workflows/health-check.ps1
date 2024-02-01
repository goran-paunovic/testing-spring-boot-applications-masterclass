# PowerShell Script to Check for HTTP 200 Status from localhost:8080 for 180 Seconds

# Define the URI to check
$uri = "http://localhost:8080"
# Define timeout (180 seconds)
$timeout = 180
# Define the interval between checks (in seconds)
$interval = 10
# Initialize timer
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

while ($stopwatch.Elapsed.TotalSeconds -lt $timeout) {
  try {
    # Attempt to get response from the URI
    $response = Invoke-WebRequest -Uri $uri -Method Get -TimeoutSec $interval
    # Check if the status code is 200
    if ($response.StatusCode -eq 200) {
      Write-Host "Success: Received HTTP 200 status code from $uri."
      break
    } else {
      Write-Host "Received HTTP status code $($response.StatusCode) from $uri."
    }
  } catch {
    # Catch and display any error if the request fails
    Write-Host "Error: Could not connect to $uri. Retrying in $interval seconds..."
  }
  # Wait for the interval before trying again
  Start-Sleep -Seconds $interval
}

# Check if loop exited due to timeout
if ($stopwatch.Elapsed.TotalSeconds -ge $timeout) {
  Write-Host "Failure: Did not receive HTTP 200 status code from $uri within $timeout seconds."
}

# Stop the stopwatch
$stopwatch.Stop()
