#
# ~/.bashrc
#

# If not running interactively, don't do anything
#
# pwd variable blue painted
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#Default PS1='[\u@\h \W]\$ '
PS1=' \u@\h  \e[34m\w\e[0m \$ '
#
# Qt
export QT_QPA_PLATFORMTHEME=qt5ct
