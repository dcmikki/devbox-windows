# Windows Development Environment
Intended to define my personal development environment for Windows.

I'll occasionally have to use Windows for projects at work, so I also want a Windows machine with some dev tools and customisations. This setup may be completely automated with something in the future, but for now it's a few batch files that need to be run in a certain order.

The goal is to get something on Windows that's a very decent approximation of my Linux shell setup. This could probably be achieved best with the new 'Bash for Windows' feature in Windows 10, but sadly I still need to work with Windows 7 for some projects. The best option otherwise is to get a nice Git Bash setup running.

## Git Bash for Windows Setup

### Install Environment

First up, on the target machine, download the initial-bootstrap.bat and install-font.vbs files in this repository and save them to your user profile directory at `%USERPROFILE%`. Then run cmd.exe as Administrator and run that script:
```
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation.  All rights reserved.

C:\Windows\system32>cd %USERPROFILE%

c:\Users\cygwin>initial-bootstrap.bat

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----        24/06/2017     20:32            chocInstall
Unable to set PowerShell to use TLS 1.2 and TLS 1.1 due to old .NET Framework i
nstalled. If you see underlying connection closed or trust errors, you may need
 to do one or more of the following: (1) upgrade to .NET Framework 4.5+ and Pow
erShell v3, (2) specify internal Chocolatey package location (set $env:chocolat
eyDownloadUrl prior to install or host the package internally), (3) use the Dow
nload + PowerShell method of install. See https://chocolatey.org/install for al
l install options.
Getting latest version of the Chocolatey package for download.
Getting Chocolatey from https://chocolatey.org/api/v2/package/chocolatey/0.10.7

...

Chocolatey installed 9/9 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

Installed:
 - chocolatey-core.extension v1.3.1
 - conemu v17.6.22.0
 - keepass.install v2.36
 - 7zip v16.4.0.20170506
 - keepass v2.36
 - 7zip.install v16.4.0.20170506
 - git.install v2.13.1.2
 - curl v7.54.1
 - git v2.13.1.2
```

Start up ConEmu. On first boot, it will give you an opportunity to configure some options, including a startup task; choose the `{Bash::Git bash}` option. For now this is all that's needed, as the settings file for ConEmu will be configured during the dotfiles bootstrap.

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

Now clone my dotfiles repository using SSH:
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
