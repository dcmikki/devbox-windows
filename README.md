# Windows Development Environment
Intended to define my personal development environment for Windows.

I'll occasionally have to use Windows for projects at work, so I also want a Windows machine with some dev tools and customisations. This setup may be completely automated with something in the future, but for now it's a few batch files that need to be run in a certain order.

The goal is to get something on Windows that's a very decent approximation of my Linux shell setup. This could probably be achieved best with the new 'Bash for Windows' feature in Windows 10, but sadly I still need to work with Windows 7 for some projects. The best option otherwise is running [MSYS2](http://www.msys2.org). This is superior to Git Bash just because it comes with a package manager you can use to easily install any additional packages needed at any point in the future.

## Setup

### MSYS2

At present, unfortunately MSYS2 doesn't have an unattended installer. There is a [Chocolately package](https://chocolatey.org/packages/msys2), but it only extracts an archive, it doesn't do a proper install with shortcuts to the console and so on. Actually, in any case, it doesn't even run through installing that package without errors, so it's not a great option anyway.

That said, download the [MSYS2 installer](http://repo.msys2.org/distrib/x86_64/msys2-x86_64-20161025.exe) and run it. After installation, run MSYS2 and do a `pacman -Syu` to update the system. That command will instruct you to restart MSYS2. Do so, then run `pacman -Su` to resume and complete updating the system.

### Run Bootstrap

On the target machine, download the initial-bootstrap.bat and install-font.vbs files in this repository and save them to your user profile directory at `%USERPROFILE%`. Then run cmd.exe as Administrator and run that script:
```
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation.  All rights reserved.

C:\Windows\system32>cd %USERPROFILE%

c:\Users\cygwin>initial-bootstrap.bat

This will use chocolately to install various packages, the terminal connector for ConEmu (used for getting 256 colours to work correctly) and the Source Code Pro patched font.
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

There's a bootstrap.bat file that can be run to create links to all the config files. Run it from cmd.exe as Administrator (output should be something similar):
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

Now the location containing msys-2.0.dll, usually `C:\Program Files\Git\usr\bin`, needs to be put on the system PATH.

After that, start a new instance of ConEmu and verify everything is linked correctly. If correct, the .bashrc should be loaded with no problems and the correct prompt should be visible.

## Vim

Vim is my main text editor. I went through a bit of an adventure trying to get a setup for Windows that was usuable. I originally thought my plugin setup would be quite transferrable, but that turned out not to be the case. I ended up abandoning my attempt to get YouCompleteMe to work on Windows. I decided it wasn't all that important anyway, as I wouldn't be doing any serious programming on Windows, only DevOps type stuff. Then I thought I'd just use everything except YouCompleteMe, but the performance in Vim in Git Bash was still terrible (I'm talking 10+ seconds just to open a file for editing).

I've ended up with the following setup:
* ConEmu running Git Bash with settings for 256 colour support
* The build of Vim that comes with Git Bash
* The .vimrc linked from my dotfiles with settings for 256 colour support and essential plugins
* The Windows build of Vim installed alongside the build that comes with Git Bash (good for 'Right Click -> Edit With Vim')
* A .gvimrc linked from my dotfiles

The Windows and Git Bash builds seem to be able to sit alongside each other just fine.

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
