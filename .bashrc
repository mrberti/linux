# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # define variables for color codes
	col_code_black="\[\033[0;30m\]"
	col_code_dark_grey="\[\033[1;30m\]"
	col_code_red="\[\033[0;31m\]"
	col_code_light_red="\[\033[1;31m\]"
	col_code_green="\[\033[0;32m\]"
	col_code_light_green="\[\033[1;32m\]"
	col_code_brown="\[\033[0;33m\]"
	col_code_yellow="\[\033[1;33m\]"
	col_code_blue="\[\033[0;34m\]"
	col_code_light_blue="\[\033[1;34m\]"
	col_code_purple="\[\033[0;35m\]"
	col_code_light_purple="\[\033[1;35m\]"
	col_code_cyan="\[\033[0;36m\]"
	col_code_light_cyan="\[\033[1;36m\]"
	col_code_light_grey="\[\033[0;37m\]"
	col_code_white="\[\033[1;37m\]"
	col_code_no_color="\[\033[0m\]"
	
	# assign standard values
	col_code_uname=$col_code_green
	col_code_host=$col_code_green
	col_code_dir=$col_code_light_blue
	col_code_prompt=$col_code_light_grey
	
	# define color for hostname dependant on hostname
	case "$(hostname)" in
		"SIMONBEW7-NB")
			#col_code_host=$col_code_red
			;;
	esac
	
	# define color for hostname dependant on SSH connection
	if [ -n "$SSH_CONNECTION" ]; then
		#echo "SSH connection is alive"
		col_code_host=$col_code_yellow
	fi

	#define color for username
	if [ $EUID -eq "0" ] ; then
		col_code_uname=$col_code_red
	fi
	
    #PS1='${debian_chroot:+($debian_chroot)}\t \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	PS1="\n$col_code_uname\u@$col_code_host\h$col_code_no_color:$col_code_dir\w\n$col_code_prompt\A \[\033[0m\]\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

## include further definitions which are specific to the machine and ignored by git
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

## Set display variable for xserver
#function get_xserver ()
#{
#    case $TERM in
#       xterm )
#            XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )    
#            XSERVER=${XSERVER%%:*}
#            ;;
#        aterm | rxvt)           
#           ;;
#   esac  
#}
#
#if [ -z ${DISPLAY:=""} ]; then
#    get_xserver
#    if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) || \
#      ${XSERVER} == "unix" ]]; then 
#        DISPLAY=":0.0"          # Display on local host.
#    else
#       DISPLAY=${XSERVER}:0.0  # Display on remote host.
#    fi
#fi
#
#export DISPLAY

## Use this to set display variable in cygwin
#if [ -z "$DISPLAY" ] ; then
#	export DISPLAY=":0.0"
#fi

#LANG=de_DE.UTF-8
#LANG=en_EN.UTF-8

