# Устанавливаем ссылку на страницу релизов
$repoUrl = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"

try {
    # Получаем информацию о последнем релизе
    $release = Invoke-RestMethod -Uri $repoUrl
} catch {
    Write-Error "Не удалось получить информацию о последнем релизе. Проверьте подключение к интернету или URL."
    exit 1
}

# Ищем ссылку на нужный файл msixbundle
$fileUrl = $release.assets | Where-Object { $_.browser_download_url -like "*.msixbundle" } | Select-Object -ExpandProperty browser_download_url

if (-not $fileUrl) {
    Write-Error "Не удалось найти файл msixbundle в последнем релизе."
    exit 1
}

# Скачиваем файл
try {
    Invoke-WebRequest -Uri $fileUrl -OutFile "Microsoft.DesktopAppInstaller.msixbundle"
} catch {
    Write-Error "Ошибка при скачивании файла msixbundle."
    exit 1
}

# Устанавливаем скачанный msixbundle
try {
    Add-AppxPackage -Path .\Microsoft.DesktopAppInstaller.msixbundle
    Write-Output "Winget успешно установлен."
} catch {
    Write-Error "Ошибка при установке пакета msixbundle."
    exit 1
}
