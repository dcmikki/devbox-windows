# Windows Development Environment
Intended to define my personal development environment for Windows.

I'll occasionally have to use Windows for projects at work, so I also want a Windows machine with some dev tools and customisations. This setup may be completely automated with something in the future, but for now it's a few batch files that need to be run in a certain order.

The goal is to get something on Windows that's a very decent approximation of my Linux shell setup. This could probably be achieved best with the new 'Bash for Windows' feature in Windows 10, but sadly I still need to work with Windows 7 for some projects. The best option otherwise is running [MSYS2](http://www.msys2.org). This is superior to Git Bash just because it comes with a package manager you can use to easily install any additional packages needed at any point in the future.

## Setup

### MSYS2

At present, unfortunately MSYS2 doesn't have an unattended installer. There is a [Chocolately package](https://chocolatey.org/packages/msys2), but it only extracts an archive, it doesn't do a proper install with shortcuts to the console and so on. Actually, in any case, it doesn't even run through installing that package without errors, so it's not a great option anyway.

That said, download the [MSYS2 installer](http://repo.msys2.org/distrib/x86_64/msys2-x86_64-20161025.exe) and run it. After installation, run MSYS2 and do a `pacman -Syu` to update the system. That command will instruct you to restart MSYS2. Do so, then run `pacman -Su` to resume and complete updating the system. Once complete, install Git with `pacman -S git`. Installing git actually also installs the `vim` package, I guess because it also wants to use that as the default editor.

### Run Bootstrap

On the target machine, download the initial-bootstrap.bat and install-font.vbs files in this repository and save them to your user profile directory at `%USERPROFILE%`. Then run cmd.exe as Administrator and run that script:
```
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation.  All rights reserved.

C:\Windows\system32>cd %USERPROFILE%

C:\Users\cygwin>initial-bootstrap.bat

C:\Users\cygwin>set choco_install_path="C:\ProgramData\chocolatey\bin"

C:\Users\cygwin>set msys2_install_path="C:\msys64"

C:\Users\cygwin>set terminal_connector_path="C:\msys64\conemu-msys2-64.exe"

C:\Users\cygwin>set font_path="C:\Users\cygwin\fonts"

C:\Users\cygwin>set source_code_pro_font_path="C:\Users\cygwin\fonts\Sauce Code
Pro Semibold Nerd Font Complete Mono Windows Compatible.ttf"

C:\Users\cygwin>set source_code_pro_font_name="Sauce Code Pro Semibold Nerd Font
 Complete Mono Windows Compatible.ttf"

C:\Users\cygwin>set source_code_pro_font_url="https://github.com/ryanoasis/nerd-
fonts/raw/master/patched-fonts/SourceCodePro/Semibold/complete/Sauce%20Code%20Pr
o%20Semibold%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf"

C:\Users\cygwin>if not exist "C:\ProgramData\chocolatey\bin" ()

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----        09/07/2017     21:15            chocInstall
Unable to set PowerShell to use TLS 1.2 and TLS 1.1 due to old .NET Framework i
nstalled. If you see underlying connection closed or trust errors, you may need
 to do one or more of the following: (1) upgrade to .NET Framework 4.5+ and Pow
erShell v3, (2) specify internal Chocolatey package location (set $env:chocolat
eyDownloadUrl prior to install or host the package internally), (3) use the Dow
nload + PowerShell method of install. See https://chocolatey.org/install for al
l install options.
Getting latest version of the Chocolatey package for download.
Getting Chocolatey from https://chocolatey.org/api/v2/package/chocolatey/0.10.7
.
Downloading 7-Zip commandline tool prior to extraction.
Extracting C:\Users\cygwin\AppData\Local\Temp\chocolatey\chocInstall\chocolatey
.zip to C:\Users\cygwin\AppData\Local\Temp\chocolatey\chocInstall...
Installing chocolatey on this machine
Creating ChocolateyInstall as an environment variable (targeting 'Machine')
  Setting ChocolateyInstall to 'C:\ProgramData\chocolatey'
WARNING: It's very likely you will need to close and reopen your shell
  before you can use choco.
Restricting write permissions to Administrators
We are setting up the Chocolatey package repository.
The packages themselves go to 'C:\ProgramData\chocolatey\lib'
  (i.e. C:\ProgramData\chocolatey\lib\yourPackageName).
A shim file for the command line goes to 'C:\ProgramData\chocolatey\bin'
  and points to an executable in 'C:\ProgramData\chocolatey\lib\yourPackageName
'.

Creating Chocolatey folders if they do not already exist.

WARNING: You can safely ignore errors related to missing log files when
  upgrading from a version of Chocolatey less than 0.9.9.
  'Batch file could not be found' is also safe to ignore.
  'The system cannot find the file specified' - also safe.
chocolatey.nupkg file not installed in lib.
 Attempting to locate it from bootstrapper.
PATH environment variable does not have C:\ProgramData\chocolatey\bin in it. Add
ing...
WARNING: Not setting tab completion: Profile file does not exist at
'C:\Users\cygwin\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'.
Chocolatey (choco.exe) is now ready.
You can call choco from anywhere, command line or powershell by typing choco.
Run choco /? for a list of functions.
You may need to shut down and restart powershell and/or consoles
 first prior to using choco.
Ensuring chocolatey commands are on the path
Ensuring chocolatey.nupkg is in the lib folder

C:\Users\cygwin>choco install -y 7zip conemu curl keepass vim
Chocolatey v0.10.7
Installing the following packages:
7zip;conemu;curl;keepass;vim
By installing you accept licenses for the packages.

...

Installed:
 - chocolatey-core.extension v1.3.1
 - conemu v17.7.5.0
 - keepass.install v2.36
 - 7zip v16.4.0.20170506
 - keepass v2.36
 - 7zip.install v16.4.0.20170506
 - vim v8.0.604
 - curl v7.54.1

C:\Users\cygwin>if not exist "C:\msys64\conemu-msys2-64.exe" (
curl -k -L --output connector.7z https://github.com/Maximus5/cygwin-connector/re
leases/download/v0.7.4/terminals.v0.7.4.7z
 7z e connector.7z -o"C:\msys64" conemu-msys2-64.exe -r
 del connector.7z
)
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   609    0   609    0     0   1053      0 --:--:-- --:--:-- --:--:--  1053
100 35973  100 35973    0     0  26470      0  0:00:01  0:00:01 --:--:-- 95928

7-Zip [64] 16.04 : Copyright (c) 1999-2016 Igor Pavlov : 2016-10-04

Scanning the drive for archives:
1 file, 35973 bytes (36 KiB)

Extracting archive: connector.7z
--
Path = connector.7z
Type = 7z
Physical Size = 35973
Headers Size = 308
Method = LZMA:192k BCJ
Solid = +
Blocks = 2

Everything is Ok

Files: 5
Size:       152760
Compressed: 35973

C:\Users\cygwin>if not exist C:\Users\cygwin\fonts mkdir C:\Users\cygwin\fonts

C:\Users\cygwin>if not exist "C:\Users\cygwin\fonts\Sauce Code Pro Semibold Nerd
 Font Complete Mono Windows Compatible.ttf" (
curl -k -L --output "C:\Users\cygwin\fonts\Sauce Code Pro Semibold Nerd Font Com
plete Mono Windows Compatible.ttf" "https://github.com/ryanoasis/nerd-fonts/raw/
master/patched-fonts/SourceCodePro/Semibold/complete/Sauce%20Code%20Pro%20Semibo
ld%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf"
 call cscript install-font.vbs "Sauce Code Pro Semibold Nerd Font Complete Mono
Windows Compatible.ttf" "C:\Users\cygwin\fonts"
)
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   262  100   262    0     0    389      0 --:--:-- --:--:-- --:--:--   389
100  570k  100  570k    0     0   376k      0  0:00:01  0:00:01 --:--:--  960k
Microsoft (R) Windows Script Host Version 5.8
Copyright (C) Microsoft Corporation. All rights reserved.

C:\Users\cygwin>
```

### Install Environment

Start up ConEmu. On first boot, it will give you an opportunity to configure some options, including a startup task; choose the `{Bash::Msys2-64}` option. For now this is all that's needed, as the settings file for ConEmu will be configured during the dotfiles bootstrap.

### Configure Bash Environment

Now that ConEmu is running the Bash shell, it will normally load things like .bashrc and .bash_profile, so these can be supplied from my dotfiles repository. First, to clone with SSH, I'll need to get a copy of my private key onto the machine. For now I'm running this setup on a VM, so I've made my key available via a shared folder. At some point I'm going to create some kind of script that pulls the keys from somewhere (maybe on a USB stick or something), but for now, the step is just something like this:
```
cygwin@cygwin-PC MSYS ~
$ mkdir .ssh

cygwin@cygwin-PC MSYS ~
$ cp /E/.ssh/id_rsa .ssh

cygwin@cygwin-PC MSYS ~
$ chmod 0400 ~/.ssh/id_rsa
```

Now clone my dotfiles repository using SSH:
```
cygwin@cygwin-PC MSYS ~
$ mkdir dev && cd dev

cygwin@cygwin-PC MSYS ~/dev
$ git clone git@github.com:jacderida/dotfiles.git
Cloning into 'dotfiles'...
The authenticity of host 'github.com (192.30.253.112)' can't be established.
RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,192.30.253.112' (RSA) to the list of known hosts.
remote: Counting objects: 2410, done.
Receiving objects:  88% (2121/2410), 2.65 MiB | 555.00 KiB/s   2410eceiving objects:  86% (2073/2410), 2.65 MiB | 555.00 KiB/s
Receiving objects: 100% (2410/2410), 3.04 MiB | 588.00 KiB/s, done.
Resolving deltas: 100% (1435/1435), done.
```

Now run the bootstrap-msys2.sh file:

After that, start a new instance of ConEmu and verify everything is linked correctly. If correct, the .bashrc should be loaded with no problems and the correct prompt should be visible.

## Vim

Vim is my main text editor. I went through a bit of an adventure trying to get a setup for Windows that was usuable. I originally thought my plugin setup would be quite transferrable, but that turned out not to be the case. I ended up abandoning my attempt to get YouCompleteMe to work on Windows. I decided it wasn't all that important anyway, as I wouldn't be doing any serious programming on Windows, only DevOps type stuff. Then I thought I'd just use everything except YouCompleteMe, but the performance in Vim in Git Bash was still terrible (I'm talking 10+ seconds just to open a file for editing).

I've ended up with the following setup:
* ConEmu running Git Bash with settings for 256 colour support
* The build of Vim that comes with Git Bash
* The .vimrc linked from my dotfiles with settings for 256 colour support and essential plugins
* The Windows build of Vim installed alongside the build that comes with Git Bash (good for 'Right Click -> Edit With Vim')
* A .gvimrc linked from my dotfiles

The Windows and MSYS2 builds seem to be able to sit alongside each other just fine.

### Setup

Most of the setup is done during the bootstrap. The only thing to do before that is to setup Vundle and create the directories the vimrc specifies to use for backups:
```
cygwin@cygwin-PC » ~/dev $ cd ~
cygwin@cygwin-PC » ~ $ mkdir -p .vim/bundle
cygwin@cygwin-PC » ~ $ mkdir .vim/backup
cygwin@cygwin-PC » ~ $ mkdir .vim/tmp
cygwin@cygwin-PC » ~ $ cd .vim/bundle/
cygwin@cygwin-PC » ~/.vim/bundle $ git clone https://github.com/VundleVim/Vundle.vim.git
Cloning into 'Vundle.vim'...
remote: Counting objects: 3128, done.
Receiving objects:  79% (2472/3128), 852.01 KiB | 191.00 KiB/s   28eceiving objects:  78% (2440/3128), 852.01 KiB | 191.00 KiB/s
Receiving objects: 100% (3128/3128), 931.67 KiB | 196.00 KiB/s, done.
Resolving deltas: 100% (1101/1101), done.
```

After that just run `vi +PluginInstall +qall` from the Bash prompt and all the plugins will be installed using Vundle.
