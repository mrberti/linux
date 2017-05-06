" Python auto complete using pathogen
" execute pathogen#infect()

set nocompatible		" VI nocompatible
set backspace=2			" Backspace überall erlauben
set number				" Zeilennummern
set tabstop=4			" Tabstop
set shiftwidth=4		" << >>
set incsearch			" Inkrementelle Suche
set hls					" Suche hervorheben
set showcmd				" ??
syntax on				" Syntaxhighlighting an
set autoindent			" Autoindention an
set smartindent			" smart indent
set cindent				" C-Indention

" statusline modifizieren
set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]\ [c=\%03.3b]\ [h=\%02.2B]\ [LIN=%04l,COL=%04v][%p%%]\ [LEN=%L]
set laststatus=2

" cursor in VIM
if has('unix')
	if has('win32unix') " for cygwin
		let &t_ti.="\e[1 q"
		let &t_SI.="\e[5 q"
		let &t_EI.="\e[1 q"
		let &t_te.="\e[0 q"
	else
		if has("autocmd")
			"au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
			"au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
			"au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
			"au VimEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
		else
			echoerr "No autocmd"
		endif
	endif
else
	echoerr "Unknown OS"
endif

" Wenn das Terminal eine Maus hat einschalten
if has('mouse')
	set mouse=a
endif

" CONTROLMODE KEYMAPS
"map <C-S> :w<CR>
"map <C-BS> dbi

" INSERTMODE KEYMAPS
"imap <C-S> <Esc><C-S>
"imap  
"imap <C-BS> 
