# InstallWinget.ps1

This PowerShell script automates the process of downloading and installing the latest version of Winget (Windows Package Manager) from GitHub releases. It simplifies the installation by dynamically fetching the latest release and performing the installation in a single run.

##Features

- **Automated Latest Version Download**: The script fetches the latest release of Winget directly from the GitHub API.
- **Dynamic File Handling**: Automatically identifies and downloads the `.msixbundle` file from the latest release assets.
- **Seamless Installation**: Installs the downloaded package with a single command.

##Usage

1. **Download the Script**: Save the script as `InstallWinget.ps1` on your local machine.

 ```powershell
 # InstallWinget.ps1
 # Set a link to the releases page
 $repoUrl = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"

 # Get information about the latest release
 $release = Invoke-RestMethod -Uri $repoUrl

 # We are looking for a link to the desired msixbundle file
 $fileUrl = $release.assets | Where-Object { $_.browser_download_url -like "*.msixbundle" } | Select-Object -ExpandProperty browser_download_url

 # Download the file
 Invoke-WebRequest -Uri $fileUrl -OutFile "Microsoft.DesktopAppInstaller.msixbundle"

 # Install the downloaded msixbundle
 Add-AppxPackage -Path .\Microsoft.DesktopAppInstaller.msixbundle

 Write-Output "Winget was successfully installed."
 ```

2. **Run the Script**: Open PowerShell with administrative privileges and navigate to the directory where the script is saved. Execute the script using the following commands:

 ```powershell
 cd "path_to_your_script"
 .\InstallWinget.ps1
 ```

3. **Installation Complete**: The script will download and install the latest version of Winget. Once completed, you will see a confirmation message: `Winget was successfully installed.`

##Prerequisites

- **PowerShell**: Make sure you are running PowerShell with administrative privileges.
- **Internet Connection**: Required to fetch the latest release from GitHub.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with any improvements or bug fixes.

## Acknowledgments

- Thanks to the [Winget](https://github.com/microsoft/winget-cli) team for their continuous development and support.
