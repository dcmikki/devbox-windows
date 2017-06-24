set choco_install_path="%ALLUSERSPROFILE%\chocolatey\bin"
set git_install_path="C:\Program Files\Git"
set terminal_connector_path="C:\Program Files\Git\conemu-msys2-64.exe"

if not exist %choco_install_path% (
    @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
)
choco install -y 7zip conemu curl git keepass 
if not exist %terminal_connector_path% (
    curl -k -L --output connector.7z https://github.com/Maximus5/cygwin-connector/releases/download/v0.7.4/terminals.v0.7.4.7z
    7z e connector.7z -o%git_install_path% conemu-msys2-64.exe -r
    del connector.7z
)
