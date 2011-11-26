A. Ford's Dotfiles
##################

My take on a dotfile repo. Heavily based off of Zach Holman's `dotfile repo 
<https://github.com/holman/dotfiles>`_. Using bash instead of ruby, mostly
for a challenge.

Install
=======

* ``git clone git://github.com/ajford/dotfiles.git ~/.dotfiles``
* ``cd ~/.dotfiles``
* ``bash unpack.sh``

``unpack.sh`` will automatically symlink all files to your home dir and add the
dot, i.e. ``.dotfiles/foo/bar.symlink`` will be moved to ``$HOME/.bar``.

Notice however, ``bash/`` is handled a bit differently (though I'm 
rethinking this). ``bash/bashrc`` is explicitly moved to 
``$HOME/.bashrc`` and ``bash/`` is not walked. See below for more on
``unpack.sh``.

Topics
======

Everything's built around topic areas. Aids keeping track of what corresponds 
to what.

Components
==========

There's a lot going on in this repo. Here's a rundown:

* Topic folders - Used to separate sections
* ``unpack.sh`` - The heavy lifter, used to integrate the repo into your system
* ``*/foo.sh`` - These files are sourced to load additional bash stuff
* ``*/bar.alias`` - These are sourced to include various aliases
* ``*/baz.symlink`` - These are symlinked into $HOME by ``unpack.sh``


A couple of folders are treated differently

* **bin/**: This gets added to $PATH via the bashrc. It is not walked by
            the unpack function.
* **bash/func.d**: This folder is walked via the bashrc file. Its used to
            integrate bash functions that I use, and allows them to be 
            separated into different files. 

Unpack Behavior
===============

The basic behavior is as follows:

* **topic/*.symlink**: Any files ending with ``*.symlink`` will be copied
            to ``$HOME`` with the extension removed, and the prefix dot 
            added. I.e., ``foo/bar.symlink`` will become ``$HOME/.bar``.
* **bash/bashrc**: This file is handled differently. It is symlinked to 
            ``$HOME/.bashrc``, and handles all ``foo/bar.sh`` and 
            ``foo/baz.alias`` files.
* **$HOME/.dotfiles_home**: ``unpack.sh`` creates this file to point to the
            location of the dotfiles directory for use in the bashrc file.

``unpack.sh`` gives you a few options when it runs into an existing file while
attempting to unpack ``*.symlink`` files. Default behavior is to create 
a backup copy of the existing file in the form of ``$HOME/.existing_foo.bak``.
You are also given the opportunity to skip that file or overwrite it. There are
also options to apply your choice to all following conflicts.

Dependencies
============

Most of what's in here shouldn't require dependencies. That's part of what made
me choose bash for the unpack script. The virtualenv and python stuff of course
depends on python, and virtualenvwrapper is required for the ``workon_walk`` 
bash function. The dotfiles repo should work fine without these dependencies, 
just not function in regards to those sections.

Bugs
====

As this repo is really meant for my personal use, I may occasionally make 
changes that break things due to dependencies or what not. If you have any 
trouble, feel free to `create an issue 
<https://github.com/ajford/dotfiles/issues>`_.

Upcoming
========

Sometime soon there should be a script written to remove the changes made by 
``unpack.sh``. This may require a change to the extension that ``unpack.sh``
adds when backing up existing files (to prevent moving files not manipulated
by ``unpack.sh``.
