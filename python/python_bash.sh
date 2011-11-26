if [ -f ~/.pythonrc ]; then
	export PYTHONSTARTUP=~/.pythonrc
fi

export PIP_RESPECT_VIRTUALENV=true
export WORKON_HOME=~/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
