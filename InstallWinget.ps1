# Set the URL for the releases page
$repoUrl = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"

try {
    # Retrieve information about the latest release
    $release = Invoke-RestMethod -Uri $repoUrl
} catch {
    Write-Error "Failed to fetch the latest release information. Check your internet connection or URL."
    exit 1
}

# Find the download link for the required msixbundle file
$fileUrl = $release.assets | Where-Object { $_.browser_download_url -like "*.msixbundle" } | Select-Object -ExpandProperty browser_download_url

if (-not $fileUrl) {
    Write-Error "Could not find an msixbundle file in the latest release."
    exit 1
}

# Download the file
try {
    Invoke-WebRequest -Uri $fileUrl -OutFile "Microsoft.DesktopAppInstaller.msixbundle"
} catch {
    Write-Error "Error downloading the msixbundle file."
    exit 1
}

# Install the downloaded msixbundle
try {
    Add-AppxPackage -Path .\Microsoft.DesktopAppInstaller.msixbundle
    Write-Output "Winget has been successfully installed."
} catch {
    Write-Error "Error installing the msixbundle package."
    exit 1
}
