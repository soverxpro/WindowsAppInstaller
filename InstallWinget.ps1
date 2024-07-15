# ������������� ������ �� �������� �������
$repoUrl = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"

# �������� ���������� � ��������� ������
$release = Invoke-RestMethod -Uri $repoUrl

# ���� ������ �� ������ ���� msixbundle
$fileUrl = $release.assets | Where-Object { $_.browser_download_url -like "*.msixbundle" } | Select-Object -ExpandProperty browser_download_url

# ��������� ����
Invoke-WebRequest -Uri $fileUrl -OutFile "Microsoft.DesktopAppInstaller.msixbundle"

# ������������� ��������� msixbundle
Add-AppxPackage -Path .\Microsoft.DesktopAppInstaller.msixbundle

Write-Output "Winget was successfully installed."
