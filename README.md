# Windows Development Environment
Intended to define my personal development environment for Windows.

I'll occasionally have to use Windows for projects at work, so I also want a Windows machine with some dev tools and customisations. This setup may be automated with something in the future, but for now it will just be some notes on what I installed and how I configured it.

The goal is to get something on Windows that's a very decent approximation of my Linux shell setup. This could probably be achieved best with the new 'Bash for Windows' feature in Windows 10, but sadly I still need to work with Windows 7 for some projects. The best option otherwise is to get a nice Git Bash setup running.

The Windows package manager [Chocolatey](https://chocolatey.org/) will be used at various points, so install it now. Run the following from cmd.exe in administrative mode:
```
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

## Git Bash for Windows Setup

### Install Environment

First up, install [Git Bash](https://git-for-windows.github.io/) and [ConEmu](https://conemu.github.io/), an improved console emulator. Both of those are installed as part of the [Cmder](http://cmder.net/) package, however, cmder continues to run a Windows-based shell, whereas my preference is for the emulated Bash shell provided by Git for Windows. Run cmd.exe as Administrator and install both using choco.

```
C:\Windows\system32>choco install -y conemu git
Chocolatey v0.10.7
Installing the following packages:
conemu;git
By installing you accept licenses for the packages.
Progress: Downloading ConEmu 17.6.5.0... 100%

ConEmu v17.6.5.0 [Approved]
conemu package files install completed. Performing other installation steps.
Downloading ConEmu 64 bit
  from 'https://github.com/Maximus5/ConEmu/releases/download/v17.06.05/ConEmuSet
up.170605.exe'
Progress: 100% - Completed download of C:\Users\cygwin\AppData\Local\Temp\chocol
atey\ConEmu\17.6.5.0\ConEmuSetup.170605.exe (5.1 MB).
Download of ConEmuSetup.170605.exe (5.1 MB) completed.
Hashes match.
Installing ConEmu...
ConEmu has been installed.
  conemu may be able to be automatically uninstalled.
 The install of conemu was successful.
  Software installed as 'exe', install location is likely default.
Progress: Downloading git.install 2.13.0... 100%
Progress: Downloading chocolatey-core.extension 1.3.1... 100%
Progress: Downloading git 2.13.0... 100%

chocolatey-core.extension v1.3.1 [Approved]
chocolatey-core.extension package files install completed. Performing other inst
allation steps.
 Installed/updated chocolatey-core extensions.
 The install of chocolatey-core.extension was successful.
  Software installed to 'C:\ProgramData\chocolatey\extensions\chocolatey-core'

git.install v2.13.0 [Approved]
git.install package files install completed. Performing other installation steps
.
Installing 64 bit version
Installing git.install...
git.install has been installed.
WARNING: Can't find git.install install location
  git.install can be automatically uninstalled.
Environment Vars (like PATH) have changed. Close/reopen your shell to
 see the changes (or in powershell/cmd.exe just type `refreshenv`).
 ShimGen has successfully created a shim for Git-2.13.0-32-bit.exe
 The install of git.install was successful.
  Software installed to 'C:\Program Files\Git\'

git v2.13.0 [Approved]
git package files install completed. Performing other installation steps.
 The install of git was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

Chocolatey installed 4/4 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

C:\Windows\system32>
```

With these installed, cmd.exe can happily be discarded (for the vast majority of things). Start up ConEmu. On first boot, it will give you an opportunity to configure some options, including a startup task; choose the `{Bash::Git bash}` option. There's a good range of pre-configured colour schemes to select from.

### Configure Bash Environment

#### Git Setup

Now that ConEmu is running the Bash shell, it will normally load things like .bashrc and .bash_profile, so these can be supplied from my dotfiles repository. First, to clone with SSH, I'll need to get a copy of my private key onto the machine. For now I'm running this setup on a VM, so I've made my key available via a shared folder. At some point I'm going to create some kind of script that pulls the keys from somewhere (maybe on a USB stick or something), but for now, the step is just something like this:
```
cygwin@cygwin-PC MINGW64 ~
$ mkdir .ssh

cygwin@cygwin-PC MINGW64 ~
$ cp /E/.ssh/id_rsa .ssh

cygwin@cygwin-PC MINGW64 ~
$ chmod 0400 ~/.ssh/id_rsa
```

We should now be able to clone my dotfiles repository using SSH:
```
cygwin@cygwin-PC MINGW64 ~
$ mkdir dev && cd dev

cygwin@cygwin-PC MINGW64 ~/dev
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

The .gitconfig should now be installed by linking it from the dotfiles repository to where msysgit expects it to be. The .githelpers file should also be installed in the same manner, and a wrapper script for using vimdiff on the terminal needs to go into `%USERPROFILE%\.local\bin`.

Sadly, symlinks in Windows can only be made using cmd.exe. For some reason, the command `mklink` isn't an actual standalone program, but some kind of extension to cmd.exe. This seems kind of bizarre, since it also makes the command unavailable to things like Powershell, but hey ho. Even if you're creating the link in your own profile directory, it seems you still need to be Administrator to run this command, so run cmd.exe as Administrator.
```
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation.  All rights reserved.

C:\Windows\system32>cd c:\Users\cygwin

c:\Users\cygwin>mklink .gitconfig c:\Users\cygwin\dev\dotfiles\git\.gitconfig
symbolic link created for .gitconfig <<===>> c:\Users\cygwin\dev\dotfiles\git\.gitconfig

C:\Users\cygwin>mkdir -p .local\bin

C:\Users\cygwin>cd .local\bin

c:\Users\cygwin\.local\bin>mklink git_diff_wrapper c:\Users\cygwin\dev\dotfiles\
git\git_diff_wrapper
symbolic link created for git_diff_wrapper <<===>> c:\Users\cygwin\dev\dotfiles\
git\git_diff_wrapper

c:\Users\cygwin\.local\bin>cd ..\..

c:\Users\cygwin>mklink .githelpers c:\Users\cygwin\dev\dotfiles\git\.githelpers
symbolic link created for .githelpers <<===>> c:\Users\cygwin\dev\dotfiles\git\.
githelpers
```

Start a new instance of ConEmu and verify this is working as intended:
```
cygwin@cygwin-PC MINGW64 ~
$ git config --list --show-origin
file:"C:\\ProgramData/Git/config"       core.symlinks=false
file:"C:\\ProgramData/Git/config"       core.autocrlf=true
file:"C:\\ProgramData/Git/config"       core.fscache=true
file:"C:\\ProgramData/Git/config"       color.diff=auto
file:"C:\\ProgramData/Git/config"       color.status=auto
file:"C:\\ProgramData/Git/config"       color.branch=auto
file:"C:\\ProgramData/Git/config"       color.interactive=true
file:"C:\\ProgramData/Git/config"       help.format=html
file:"C:\\ProgramData/Git/config"       rebase.autosquash=true
file:"C:\\Program Files\\Git\\mingw64/etc/gitconfig"    http.sslcainfo=C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt
file:"C:\\Program Files\\Git\\mingw64/etc/gitconfig"    diff.astextplain.textconv=astextplain
file:"C:\\Program Files\\Git\\mingw64/etc/gitconfig"    credential.helper=manager
file:C:/Users/cygwin/.gitconfig user.name=Chris O'Neil
file:C:/Users/cygwin/.gitconfig user.email=chris.oneil@gmail.com
file:C:/Users/cygwin/.gitconfig diff.external=git_diff_wrapper
file:C:/Users/cygwin/.gitconfig pager.diff=
...
```

The output is truncated here, but clearly it's reading my custom settings.

#### Bash Setup

Similar to Git, it's simply a case of linking in the bashrc, which seems to be quite cross platform for now. So run cmd.exe as Administrator again, and link in the bashrc.
```
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation.  All rights reserved.

C:\Windows\system32>cd c:\Users\cygwin

c:\Users\cygwin>mklink .bashrc c:\Users\cygwin\dev\dotfiles\bash\.bashrc
symbolic link created for .bashrc <<===>> c:\Users\cygwin\dev\dotfiles\bash\.bas
hrc
```

#### Font Setup

Grab a font from [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts). It obviously needs to be a Windows compatible font. [Source Code Pro](https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Semibold/complete/Sauce%20Code%20Pro%20Semibold%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf) at 14pt looks pretty good. Once installed, change the settings in ConEmu to use that font.

Font installation could be [automated](https://superuser.com/questions/201896/how-do-i-install-a-font-from-the-windows-command-prompt) quite easily.
