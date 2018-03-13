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
    compensate=0
    if [[ $VIRTUAL_ENV != "" ]]
    then
        # Right alignment compensation factor. Color requires 7 chars, clearing
        # color requires 4 chars. Total of 11 chars.
        compensate=11

        venv="$IGreen(${VIRTUAL_ENV##*/})$Color_Off"
    else
        venv=""
    fi
    echo -e "$venv"
    return $compensate
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
    compensate=0
    if [[ -n $_branch ]]; then
        if [ "x$dirty" == "x" ]; then
            branch="$IGreen[${_branch}]"
        else
            branch="$IRed[${_branch}${dirty}]"
        fi
        branch="$branch$Color_Off"

        # Right alignment compensation factor. Color requires 7 chars, clearing
        # color requires 4 chars. Total of 11 chars.
        compensate=11
    fi
    echo -e $branch
    return $compensate
}

# Right aligned prompt section, based on 
# http://superuser.com/a/517110/164671
function prompt_right() {
    # Right alignment compensation factor
    compensate=0
    venv=`get_venv`

    # Use return status to check how many chars to compensate for
    # during right alignment.
    compensate=$((compensate+PIPESTATUS))
    gs=`git_stuff`

    # Use return status to check how many chars to compensate for
    # during right alignment.
    compensate=$((compensate+PIPESTATUS))
    echo -e "$venv $gs"

    # Return the compensation factor so `generate_prompt` can use it.
    return $compensate
}

function prompt_left() {
    out="\u@\h:"
    if [[ $(pwd|grep $SANDBOX_HOME/) && "X$SANDBOX_NAME" != "X" ]]; then
        out="$out$(pwd|sed "s#$SANDBOX#{$SANDBOX_NAME}#")"
    else
        out="$out\w"
    fi
    echo -e $out
}

function prompt_line_2() {
    local pline_2="$ "
    if [ $1 == 0 ]; then
        pline_2="$IGreen\$ $Color_Off"
    elif [ $1 == 1 ]; then
        pline_2="$IRed\$ $Color_Off"
    else
        pline_2="$IRed[$1]\$ $Color_Off"
    fi
    echo -e "$pline_2"
}

function generate_prompt() {
    local EXIT="$?"
    # Right alignment compensation factor
    COMPENSATE=0
    pr=`prompt_right`

    #Use return status from prompt_right to set the compensation factor
    COMPENSATE=$((COMPENSATE+PIPESTATUS))

    PS1=$(printf "%*s\r%s\n%s" "$(($(tput cols) + ${COMPENSATE}))"\
        "$pr" "$(prompt_left)" "$(prompt_line_2 $EXIT)")
    
}

PROMPT_COMMAND=generate_prompt
