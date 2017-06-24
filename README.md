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

There's a bootstrap.bat file that can be run to create links to all the config files. Run it from cmd.exe as Administrator:
```
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation.  All rights reserved.

C:\Windows\system32>cd c:\Users\cygwin\dev\dotfiles

c:\Users\cygwin\dev\dotfiles>bootstrap.bat

c:\Users\cygwin\dev\dotfiles>set dotfiles=C:\Users\cygwin\dev\dotfiles

c:\Users\cygwin\dev\dotfiles>if not exist C:\Users\cygwin\.local\bin mkdir -p C:\Users\cygwin\.local\bin

c:\Users\cygwin\dev\dotfiles>if not exist C:\Users\cygwin\.gitconfig mklink C:\Users\cygwin\.gitconfig C:\Users\cygwin\dev\dotfiles\git\.gitconfig
symbolic link created for C:\Users\cygwin\.gitconfig <<===>> C:\Users\cygwin\dev\dotfiles\git\.gitconfig

c:\Users\cygwin\dev\dotfiles>if not exist C:\Users\cygwin\.githelpers mklink C:\Users\cygwin\.githelpers C:\Users\cygwin\dev\dotfiles\git\.githelpers
symbolic link created for C:\Users\cygwin\.githelpers <<===>> C:\Users\cygwin\dev\dotfiles\git\.githelpers

c:\Users\cygwin\dev\dotfiles>if not exist C:\Users\cygwin\.local\bin\git_diff_wrapper mklink C:\Users\cygwin\.local\bin\git_diff_wrapper C:\Users\cygwin\dev\dotfiles\git\git_diff_wrapper
symbolic link created for C:\Users\cygwin\.local\bin\git_diff_wrapper <<===>> C:\Users\cygwin\dev\dotfiles\git\git_diff_wrapper

c:\Users\cygwin\dev\dotfiles>if not exist C:\Users\cygwin\.bashrc mklink C:\Users\cygwin\.bashrc C:\Users\cygwin\dev\dotfiles\bash\.bashrc
symbolic link created for C:\Users\cygwin\.bashrc <<===>> C:\Users\cygwin\dev\dotfiles\bash\.bashrc
```

Start a new instance of ConEmu and verify everything is linked correctly. If correct, the .bashrc should be loaded with no problems and the correct prompt should be visible.

#### Font Setup

Grab a font from [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts). It obviously needs to be a Windows compatible font. [Source Code Pro](https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Semibold/complete/Sauce%20Code%20Pro%20Semibold%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf) at 14pt looks pretty good. Once installed, change the settings in ConEmu to use that font.

Font installation could be [automated](https://superuser.com/questions/201896/how-do-i-install-a-font-from-the-windows-command-prompt) quite easily.

## Vim

Vim is my main text editor. On my main development machines I run quite a lot of plugins, but they're all managed using Vundle, so it should be pretty easy to get all that installed on Windows. I was able to get it all running, but performance was really bad, to the point where it was unusable. I stopped loading a few plugins and ended up with a setup that would run on the version of Vim that comes with msysgit, but it still took about 5 - 10 seconds to open an instance, and it seemed to take forever to open new files too.

With that said, I'm now going to produce a minimalist Vim setup that will keep it nice and snappy to be used with msysgit.

The first thing to do is get Vundle setup:
```
cygwin@cygwin-PC » ~/dev $ cd ~
cygwin@cygwin-PC » ~ $ mkdir -p .vim/bundle
cygwin@cygwin-PC » ~ $ cd .vim/bundle/
cygwin@cygwin-PC » ~/.vim/bundle $ git clone https://github.com/VundleVim/Vundle.vim.git
Cloning into 'Vundle.vim'...
remote: Counting objects: 3128, done.
Receiving objects:  79% (2472/3128), 852.01 KiB | 191.00 KiB/s   28eceiving objects:  78% (2440/3128), 852.01 KiB | 191.00 KiB/s
Receiving objects: 100% (3128/3128), 931.67 KiB | 196.00 KiB/s, done.
Resolving deltas: 100% (1101/1101), done.
```
