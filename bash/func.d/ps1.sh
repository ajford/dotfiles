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
