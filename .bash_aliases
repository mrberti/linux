function escape_file_path {
	# helper function to escape characters present in windows file paths
	echo $1 | sed -e 's:[\ \(\)]:\\&:g'
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias dir='dir --color=auto'
    alias ls='ls --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'

# ls aliases
alias lsa='ls -A'
alias lsl='ls -lh'
alias lsla='ls -Alh'
alias lsal=lsla
alias lsda='lsd -A'
alias LS='ls --group-directories-first'
alias LL='LS -lh'
alias LA='LS -A'
alias LAL='LS -Al'
alias LLA='LAL'

# create a alias for deleting to trashbin
alias del='mv -t ~/.trash'

# windows editor aliases
np_path_x86='/cygdrive/c/Program Files (x86)/Notepad++/notepad++.exe'
np_path_x64='/cygdrive/c/Program Files/Notepad++/notepad++.exe'

if [ -e "$np_path_x86" ]; then
	alias np=`escape_file_path "$np_path_x86"`
fi

if [ -e "$np_path_x64" ]; then
	alias np=`escape_file_path "$np_path_x64"`
fi

# linux editor aliases
alias g='gedit'
