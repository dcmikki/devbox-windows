set choco_install_path="%ALLUSERSPROFILE%\chocolatey\bin"
set font_path="%USERPROFILE%\fonts"
set source_code_pro_font_path="%USERPROFILE%\fonts\Sauce Code Pro Semibold Nerd Font Complete Mono Windows Compatible.ttf"
set source_code_pro_font_name="Sauce Code Pro Semibold Nerd Font Complete Mono Windows Compatible.ttf"
set source_code_pro_font_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Semibold/complete/Sauce%%20Code%%20Pro%%20Semibold%%20Nerd%%20Font%%20Complete%%20Mono%%20Windows%%20Compatible.ttf"

if not exist %choco_install_path% (
    @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
)
choco install -y 7zip conemu curl keepass vim
if not exist %USERPROFILE%\fonts mkdir %USERPROFILE%\fonts
if not exist %source_code_pro_font_path% (
    curl -k -L --output %source_code_pro_font_path% %source_code_pro_font_url%
    call cscript install-font.vbs %source_code_pro_font_name% %font_path%
)
