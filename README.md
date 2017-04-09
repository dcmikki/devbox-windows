# devbox-windows
Intended to define my personal development environment for Windows.

I'll occasionally have to use Windows for projects at work, so I also want a Windows machine with some dev tools. This setup may be automated with something in the future, but for now it will just be some notes on what I installed and how I configured it.

## Vim with YouCompleteMe

This section describes how to get Vim running with YouCompleteMe for auto completion. YouCompleteMe requires 64-bit versions of Vim and Python. The regular Vim installation on Windows uses a 32-bit binary, even for a 64-bit Windows installation. For some reason, the official installation stream doesn't bother building a 64-bit binary and just ships the 32-bit version. Apparently this doesn't bother most Windows users. Oh well. For me, it means getting a 64-bit build of Vim from somewhere else. Some development tools will also be required for building YouCompleteMe.

Instructions:

1. Download and install the [64-bit version of Python](https://www.python.org/downloads/windows).
2. Download and install the [Visual C++ Redistributable for Visual Studio 2015](https://www.microsoft.com/en-gb/download/confirmation.aspx?id=48145).
3. Download and install a [64-bit build of Vim](https://tuxproject.de/projects/vim/). This guide will assume the installation directory is C:\Program Files\Vim.
4. Put C:\Program Files\Vim on PATH.
5. Open cmd.exe and make sure vim will run. You should see output similar to the following:
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
