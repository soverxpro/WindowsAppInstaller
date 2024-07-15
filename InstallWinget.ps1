# Устанавливаем ссылку на страницу релизов
$repoUrl = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"

# Получаем информацию о последнем релизе
$release = Invoke-RestMethod -Uri $repoUrl

# Ищем ссылку на нужный файл msixbundle
$fileUrl = $release.assets | Where-Object { $_.browser_download_url -like "*.msixbundle" } | Select-Object -ExpandProperty browser_download_url

# Скачиваем файл
Invoke-WebRequest -Uri $fileUrl -OutFile "Microsoft.DesktopAppInstaller.msixbundle"

# Устанавливаем скачанный msixbundle
Add-AppxPackage -Path .\Microsoft.DesktopAppInstaller.msixbundle

Write-Output "Winget was successfully installed."
