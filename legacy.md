# Legacy Documenation
This documents my attempt to get Vim running on Windows with YouCompleteMe. It turns out to be too slow to be usable anyway, but that may be due to something else.

I'm keeping this here in case I want to come back to it.

## Vim with YouCompleteMe

This section describes how to get Vim running with YouCompleteMe for auto completion. YouCompleteMe requires 64-bit versions of Vim and Python. The regular Vim installation on Windows uses a 32-bit binary, even for a 64-bit Windows installation. For some reason, the official installation stream doesn't bother building a 64-bit binary and just ships the 32-bit version. Apparently this doesn't bother most Windows users. Oh well. For me, it means getting a 64-bit build of Vim from somewhere else. Some development tools will also be required for building YouCompleteMe.

Instructions:

1. Install [Chocolatey](https://chocolatey.org/), the package manager for Windows. For convenience, here is the command to run from cmd.exe (needs to be in Administrative mode):
```
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```
2. Use choco to install all the dev tools:
```
C:\Windows\system32>choco install -y 7zip cmake git python2 vcredist2015
Chocolatey v0.10.5
Installing the following packages:
7zip;cmake;git;python2;vcredist2015;windows-sdk-10
...
Chocolatey installed 19/19 packages. 0 packages failed.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).

Installed:
 - cmake v3.7.2
 - python2 v2.7.13
 - dotnet4.5 v4.5.20120822
 - kb3033929 v1.0.2
 - 7zip v16.4.0.20170403
 - chocolatey-windowsupdate.extension v1.0.2
 - cmake.install v3.7.2
 - vcredist140 v14.10.25008.0
 - git v2.12.2.2
 - kb2999226 v1.0.20161201
 - kb2919355 v1.0.20160915
 - chocolatey-core.extension v1.2.0
 - kb2919442 v1.0.20160915
 - 7zip.install v16.4.0.20170403
 - vcredist2015 v14.0.24215.20170201
 - windows-sdk-10 v10.1.10586.15
 - kb3035131 v1.0.0
 - windows-sdk-10.1 v10.1.10586.15
 - git.install v2.12.2.2
```
3. Unfortunately the cmake package for chocolatey doesn't add cmake to PATH. Add it manually.
4. Download and install the [Visual C++ 2015 Build Tools](http://landinghub.visualstudio.com/visual-cpp-build-tools).
5. Download and install a [64-bit build of Vim](https://tuxproject.de/projects/vim/). This guide will assume the installation directory is C:\Program Files\Vim.
6. Add C:\Program Files\Vim to PATH.
7. Open cmd.exe and make sure Vim will run. You should see output similar to the following:
```
C:\Users\cygwin>vim --version
VIM - Vi IMproved 8.0 (2016 Sep 12, compiled Apr  7 2017 22:45:12)
MS-Windows 64-bit console version
Included patches: 1-550
Compiled by hp@HP-PC
Huge version without GUI.  Features included (+) or not (-):
+acl             +ex_extra        -mouseshape      +tag_old_static
+arabic          +extra_search    +multi_byte      -tag_any_white
+autocmd         +farsi           +multi_lang      +tcl/dyn
-balloon_eval    +file_in_path    +mzscheme/dyn    +termguicolors
-browse          +find_in_path    -netbeans_intg   -tgetent
++builtin_terms  +float           +num64           -termresponse
+byte_offset     +folding         +packages        +textobjects
+channel         -footer          +path_extra      +timers
+cindent         +gettext/dyn     +perl/dyn        +title
+clientserver    -hangul_input    +persistent_undo -toolbar
+clipboard       +iconv/dyn       -postscript      +user_commands
+cmdline_compl   +insert_expand   +printer         +vertsplit
+cmdline_hist    +job             +profile         +virtualedit
+cmdline_info    +jumplist        +python/dyn      +visual
+comments        +keymap          +python3/dyn     +visualextra
+conceal         +lambda          +quickfix        +viminfo
+cryptv          +langmap         +reltime         +vreplace
+cscope          +libcall         +rightleft       +wildignore
+cursorbind      +linebreak       +ruby/dyn        +wildmenu
+cursorshape     +lispindent      +scrollbind      +windows
+dialog_con      +listcmds        +signs           +writebackup
+diff            +localmap        +smartindent     -xfontset
+digraphs        +lua/dyn         +startuptime     -xim
-dnd             +menu            +statusline      -xpm_w32
-ebcdic          +mksession       -sun_workshop    -xterm_save
+emacs_tags      +modify_fname    +syntax
+eval            +mouse           +tag_binary
   system vimrc file: "$VIM\vimrc"
     user vimrc file: "$HOME\_vimrc"
 2nd user vimrc file: "$HOME\vimfiles\vimrc"
 3rd user vimrc file: "$VIM\_vimrc"
      user exrc file: "$HOME\_exrc"
  2nd user exrc file: "$VIM\_exrc"
       defaults file: "$VIMRUNTIME\defaults.vim"
Compilation: cl -c /W3 /nologo  -I. -Iproto -DHAVE_PATHDEF -DWIN32  -DFEAT_CSCOP
E  -DFEAT_JOB_CHANNEL      -DWINVER=0x0501 -D_WIN32_WINNT=0x0501  /Fo.\ObjCULYHT
RZAMD64/ /MP -DHAVE_STDINT_H /Ox /GL -DNDEBUG  /MD -DFEAT_MBYTE -DDYNAMIC_ICONV
-DDYNAMIC_GETTEXT -DFEAT_TCL -DDYNAMIC_TCL -DDYNAMIC_TCL_DLL=\"tcl86.dll\" -DDYN
AMIC_TCL_VER=\"8.6\" -DFEAT_LUA -DDYNAMIC_LUA -DDYNAMIC_LUA_DLL=\"lua53.dll\" -D
FEAT_PYTHON -DDYNAMIC_PYTHON -DDYNAMIC_PYTHON_DLL=\"python27.dll\" -DFEAT_PYTHON
3 -DDYNAMIC_PYTHON3 -DDYNAMIC_PYTHON3_DLL=\"python36.dll\" -DFEAT_MZSCHEME -I "C
:\Users\hp\Desktop\racket-x64\include" -DDYNAMIC_MZSCHEME -DDYNAMIC_MZSCH_DLL=\"
libracketxxxxxxx.dll\" -DDYNAMIC_MZGC_DLL=\"libmzgcxxxxxxx.dll\" -DFEAT_PERL -DP
ERL_IMPLICIT_CONTEXT -DPERL_IMPLICIT_SYS -DDYNAMIC_PERL -DDYNAMIC_PERL_DLL=\"per
l524.dll\" -DFEAT_RUBY -DDYNAMIC_RUBY -DDYNAMIC_RUBY_VER=24 -DDYNAMIC_RUBY_DLL=\
"x64-msvcrt-ruby240.dll\" -DFEAT_HUGE /Fd.\ObjCULYHTRZAMD64/ /Zi
Linking: link /RELEASE /nologo /subsystem:console /LTCG:STATUS oldnames.lib kern
el32.lib advapi32.lib shell32.lib gdi32.lib  comdlg32.lib ole32.lib uuid.lib /ma
chine:AMD64   msvcrt.lib  user32.lib  /nodefaultlib:lua53.lib  /STACK:8388608  /
nodefaultlib:python27.lib /nodefaultlib:python36.lib   "C:\TCL\lib\tclstub86.lib
" WSock32.lib /PDB:vim.pdb -debug
```
8. Open the Git shell and setup Vundle, get my dotfiles, then copy my .vimrc:
```
cygwin@cygwin-PC MINGW64 ~
$ mkdir -p .vim/bundle

cygwin@cygwin-PC MINGW64 ~
$ cd .vim/bundle/

cygwin@cygwin-PC MINGW64 ~/.vim/bundle
$ git clone https://github.com/VundleVim/Vundle.vim.git
Cloning into 'Vundle.vim'...
remote: Counting objects: 3117, done.
remote: Total 3117 (delta 0), reused 0 (delta 0), pack-reused 3116
Receiving objects: 100% (3117/3117), 928.87 KiB | 1.23 MiB/s, done.
Resolving deltas: 100% (1095/1095), done.

cygwin@cygwin-PC MINGW64 ~/.vim/bundle
$ cd ~/dev/

cygwin@cygwin-PC MINGW64 ~/dev
$ git clone https://github.com/jacderida/dotfiles.git
Cloning into 'dotfiles'...
remote: Counting objects: 2398, done.
remote: Total 2398 (delta 0), reused 0 (delta 0), pack-reused 2398
Receiving objects: 100% (2398/2398), 3.04 MiB | 648.00 KiB/s, done.
Resolving deltas: 100% (1426/1426), done.

cygwin@cygwin-PC MINGW64 ~/dev
$ cp dotfiles/vim/.vimrc ~/_vimrc
```
The .vimrc is required because it describes all the plugins to be installed by Vundle.

9. Using cmd.exe running as Administrator, run Vim using Vundle to install all my plugins:
```
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation.  All rights reserved.

C:\Windows\system32>vim +PluginInstall +qall

# Vim will run here and probably prompt for some user input.
# My .vimrc isn't cross platform yet, so there may be some errors; for now, they can be ignored.
# After clearing those, Vundle will install every plugin specified in the .vimrc.
# I assume it just uses git to clone everything to the correct directories.
```
Note: YouCompleteMe can take 5+ minutes to install; I believe it uses many submodules.

10. Build YCM:
* After installing the C++ build tools, the start menu will have a 'Visual C++ Build Tools' entry. Look under there and open the command prompt that corresponds to the current platform, e.g. x64. This runs a command prompt with all the paths and variables that need to be declared for compiling C++ projects.
* From that command prompt, navigate to %USERPROFILE%\.vim\bundle\YouCompleteMe.
* Run install.py --msvc 14. This should run through the compilation successfully.

11. Pick some Windows compatible fonts from [nerd-fonts](https://github.com/ryanoasis/nerd-fonts/) and install them.
