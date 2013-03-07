function shrink () {
    # By Anthony Ford<ford.anthonyj AT gmail>
    # Shrink the bash prompt
	#
    OLD_PS1=$PS1
    PS1="`echo $PS1 | sed s/w/W/g` "
}

function embiggen () {
    # By Anthony Ford<ford.anthonyj AT gmail>
    # Shrink the bash prompt
	#
    PS1=$OLD_PS1
}

# Virtualenv name if in venv. Based on
# http://engineerwithoutacause.com/show-current-virtualenv-on-bash-prompt.html
function get_venv() {
    if [[ $VIRTUAL_ENV != "" ]]
    then
        venv="(${VIRTUAL_ENV##*/})"
    else
        venv=""
    fi
    echo -e "$venv"
}

# Git branch and dirtiness. Stolen from
# http://engineerwithoutacause.com/show-current-virtualenv-on-bash-prompt.html
function git_stuff() {
    if git update-index -q --refresh 2>/dev/null; git diff-index --quiet --cached HEAD --ignore-submodules -- 2>/dev/null && git diff-files --quiet --ignore-submodules 2>/dev/null
        then dirty=""
    else
       dirty="*"
    fi
    _branch=$(git symbolic-ref HEAD 2>/dev/null)
    _branch=${_branch#refs/heads/} # apparently faster than sed
    branch="" # need this to clear it when we leave a repo
    if [[ -n $_branch ]]; then
       branch="[${_branch}${dirty}]"
    fi
    echo -e $branch
}

# Right aligned prompt section, based on 
# http://superuser.com/a/517110/164671
function prompt_right() {
    echo -e "$(get_venv) $(git_stuff)"
}

function prompt_left() {
    out="\u@\h:"
    if [[ x$SANDBOX_NAME != "x" ]]
    then
    #    out="$out{$SANDBOX_NAME}$(pwd|sed "s#$SANDBOX##")/"
    out="$out$(pwd|sed "s#$SANDBOX#{$SANDBOX_NAME}#")"
    else
        out="$out\w"
    fi
    echo -e $out
}

function prompt_line_2() {
    echo -e "\$ "
}

function generate_prompt() {
    COMPENSATE=0
    PS1=$(printf "%*s\r%s\n%s" "$(($(tput cols) + ${COMPENSATE}))"\
        "$(prompt_right)" "$(prompt_left)" "$(prompt_line_2)")
    
}

PROMPT_COMMAND=generate_prompt
