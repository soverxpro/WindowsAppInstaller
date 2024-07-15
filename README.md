# InstallWinget.ps1

Этот PowerShell скрипт автоматизирует процесс скачивания и установки последней версии Winget (Windows Package Manager) из релизов GitHub. Скрипт упрощает установку, динамически получая последнюю версию и выполняя установку в один шаг.

## Возможности

- **Автоматическое скачивание последней версии**: Скрипт получает последнюю версию Winget непосредственно из GitHub API.
- **Динамическая работа с файлами**: Автоматически идентифицирует и скачивает файл `.msixbundle` из активов последнего релиза.
- **Бесшовная установка**: Устанавливает скачанный пакет с помощью одной команды.

## Использование

1. **Скачайте скрипт**: Сохраните скрипт как `InstallWinget.ps1` на вашем компьютере.

    ```powershell
    # InstallWinget.ps1
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

    Write-Output "Winget был успешно установлен."
    ```

2. **Запустите скрипт**: Откройте PowerShell с правами администратора и перейдите в директорию, где сохранен скрипт. Выполните следующие команды:

    ```powershell
    cd "путь_к_вашему_скрипту"
    .\InstallWinget.ps1
    ```

3. **Завершение установки**: Скрипт скачает и установит последнюю версию Winget. После завершения вы увидите сообщение подтверждения: `Winget был успешно установлен.`

## Требования

- **PowerShell**: Убедитесь, что вы запускаете PowerShell с правами администратора.
- **Интернет-соединение**: Необходимо для получения последней версии из GitHub.

## Лицензия

Этот проект лицензирован по лицензии MIT. Подробности см. в файле [LICENSE](LICENSE).

## Вклад

Добро пожаловать к участию! Пожалуйста, откройте issue или отправьте pull request с любыми улучшениями или исправлениями ошибок.

## Благодарности

- Спасибо команде [Winget](https://github.com/microsoft/winget-cli) за их непрерывную разработку и поддержку.
