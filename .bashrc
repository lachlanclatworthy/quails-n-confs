# Open new Windows Terminal tabs in the same directory as the current tab.
# https://learn.microsoft.com/en-us/windows/terminal/tutorials/new-tab-same-directory#mingw
PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "`cygpath -w "$PWD" -C ANSI`"'

# Display current directory in the shell prompt and window title like on Ubuntu Linux.
PS1="\[\e]0;Bash: \w\a\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

if [[ -d "${HOME}/.local/bin" ]]; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

if [[ -d "${HOME}/bin" ]]; then
    export PATH="${HOME}/bin:${PATH}"
fi

export EDITOR="nano"  # Use Nano as the default editor for `git commit` and `git rebase -i`

# Force `ln` to create proper symlinks instead of copying files (requires permission)
export MSYS="winsymlinks:nativestrict"

# Python
export PYTHONUTF8=1 # https://peps.python.org/pep-0540/#proposal
export PYTHONIOENCODING="utf-8" # https://stackoverflow.com/a/12834315
unset PYTHONLEGACYWINDOWSFSENCODING

function killall()
{
    taskkill //F //IM "$1.exe" //T
}

# No man pages on Windows :( https://stackoverflow.com/a/77485966
function man()
(
    exec 2>&1
    for t in $(type -at "$1"); do
        case "${t}" in
        alias)
            alias "$1"
            ;;
        keyword)
            echo "$1 is a shell keyword"
            help -m "$1"  # Show Bash help.
            break
            ;;
        function)
            echo "function $(declare -f "$1")"
            ;;
        builtin)
            echo "$1 is a shell builtin"
            help -m "$1"  # Show Bash help.
            break
            ;;
        file|*)
            echo "$1 is $(which "$1")"
            command "$1" --help  # Show command's help.
            break
            ;;
        esac
        echo
    done | less
)

alias vi=nvim

# currently only works from develop branch
alias ptm="git co -;git merge develop; git push; git co -"
