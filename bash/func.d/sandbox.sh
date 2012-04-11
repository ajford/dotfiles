
SANDBOX_HOME=${SANDBOX_HOME-$HOME/.sandbox}

function _mksandbox_usage {
    echo "mksandbox [-v] sandbox_name"
    echo "  -v  Make matching virtualenv"
    echo
    echo "      Creates a virtualenv by the same name. Works wonders"
    echo "      when paired with workon_walk."
}

function _rmsandbox_usage {
    echo "rmsandbox sandbox_name"
    echo "  -d  Destroy, i.e. do not archive project."
    echo
    echo "By default, rmsandbox archives the project, along"
    echo "with it's config file, to \$SANDBOX_HOME/.archive/ "
}

# Sandbox function. If no arg is given, lists all sandboxes
function mksandbox {
    typeset sandbox_name="${@: -1}"
    venv=0
    while getopts ":v" opt
    do
        case $opt in
            v)
                venv=1
                ;;
            \?)
                echo "Invalid argument: -$OPTARG" >&2
                ;;
        esac
    done

    if [ "$sandbox_name" = "" ]
    then
        _mksandbox_usage
        return 1
    fi

    sandbox="$SANDBOX_HOME/$sandbox_name"
    if [ -d $sandbox ]
    then
        echo "Sandbox $sandbox_name already exists!"
        return 1
    fi

    mkdir -p $sandbox
    if [ ! -d "$SANDBOX_HOME/.config" ]
    then
        mkdir -p $SANDBOX_HOME/.config
    fi
    echo "export SANDBOX_HOME=$SANDBOX_HOME"  >> $SANDBOX_HOME/.config/$sandbox_name.sh

    echo "Sandbox $sandbox_name successfully created"

    if [ $venv = 1 ]
    then
        mkvirtualenv $sandbox_name
        echo "Virtualenv $sandbox_name successfully created"
    fi
    sandbox $sandbox_name
}

function rmsandbox {
    typeset sandbox_name="${@: -1}"

    remove=0
    while getopts ":d" opt
    do
        case $opt in
            d)
                remove=1
                ;;
            \?)
                echo "Invalid argument: -$OPTARG" >&2
                ;;
        esac
    done


    if [ "$sandbox_name" = "" ]
    then
        _rmsandbox_usage
        return 1
    fi

    sandbox="$SANDBOX_HOME/$sandbox_name"
    if [ ! -e $SANDBOX_HOME/.archive ]
    then
        mkdir $SANDBOX_HOME/.archive
    fi

    if [ $remove = 0 ]
    then
        archive=$SANDBOX_HOME/.archive/$sandbox_name.tar
        tar -C $SANDBOX_HOME -cvf $archive $sandbox_name
        tar -C $SANDBOX_HOME/.config -rvf $archive $sandbox_name.sh
        gzip $archive
    fi

    rm -r $sandbox
    rm -r $SANDBOX_HOME/.config/$sandbox_name.sh
}

function sandbox {
    typeset sandbox_name="$1"
    if [ "$sandbox_name" = "" ]
    then
        find $SANDBOX_HOME -maxdepth 1 -type d | sed 's|$SANDBOX_HOME||'
        return 1
    fi

    sandbox="$SANDBOX_HOME/$sandbox_name"
    if [ -d $sandbox ]
    then
        cd $sandbox
        workon_walk
        if [ -e "$SANDBOX_HOME/.config/$sandbox_name.sh" ]
        then
            source $SANDBOX_HOME/.config/$sandbox_name.sh
        fi
    else
        echo "Sandbox $sandbox_name does not exist"
        return 1
    fi
}

# completion set for sandbox (BASH only for now)
_sandbox()
{
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -W "`ls $SANDBOX_HOME`" -- ${cur}) )
}

complete -o default -o nospace -F _sandbox sandbox
complete -o default -o nospace -F _sandbox rmsandbox
