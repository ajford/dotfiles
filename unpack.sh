#!/bin/bash

echo `pwd` > $HOME/.dotfiles_home
DOTFILES_HOME=`pwd`

shopt -s nullglob

ext='.symlink'

ask=true
skipall=false
overwriteall=false
backupall=false

function _get_input {

    skip=false
    overwrite=false
    backup=false
    invalid=true
    while [[ $invalid = true && $ask = true ]]
    do
        invalid=false
        echo "File ~/.$file_name exists, what do you want to do?"
        echo "  [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup (default), [B]ackup all"
        read -e input
        if [[ $input = "" ]]
        then
            input="backup"
        fi
        input=${input:0:1}
        echo
        case $input in
            s)
                skip=true
                break
                ;;
            S)
                skipall=true
                ask=false
                break
                ;;
            o)
                overwrite=true
                break
                ;;
            O)
                overwriteall=true
                ask=false
                break
                ;;
            b)
                backup=true
                break
                ;;
            B)
                backupall=true
                ask=false
                break
                ;;
            *)
                invalid=true
                echo "Invalid response."
                ;;
        esac
    done
}

function _act_on_input {
    if [[ $skip = true || $skipall = true ]]
    then
        echo "skipping .$file_name"
    fi
    if [[ $overwrite = true  || $overwriteall = true ]]
    then
        echo "overwriting .$file_name"
        ln -sf $DOTFILES_HOME/$file $HOME/.$file_name
    fi
    if [[ $backup = true || $backupall = true ]]
    then
        echo "backed up .$file_name"
        mv $HOME/.$file_name $HOME/.$file_name.bak
        ln -sf $DOTFILES_HOME/$file $HOME/.$file_name
    fi
}

function _unpack {
    file_name=${file##*/}
    file_name=${file_name%$ext}
    if [ -e $HOME/.$file_name ]
    then
        _get_input

        _act_on_input                
    else
        ln -sf $DOTFILES_HOME/$file $HOME/.$file_name
    fi
}

for dir in `ls`
do
    if [ -d $dir -a ! $dir = 'bin' ]
    then
        for file in `ls -d $dir/*$ext`
        do
            if [ $file = '.' ]
            then
                continue
            fi
            _unpack
        done
    fi
done

if [ -e bash/bashrc ]
then
    file=bash/bashrc
    _unpack
fi
shopt -u nullglob

