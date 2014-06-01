# ------------------------------------------------------------------------------
# | Log Messages                                                               |
# ------------------------------------------------------------------------------

# Header logging
e_header() {
    printf "$(tput setaf 37)$(tput bold)%s$(tput sgr0)\n" "$@"
}

# Success logging
e_success() {
    printf "$(tput setaf 64)✔ %s$(tput sgr0)\n" "$@"
}

# Error logging
e_error() {
    printf "$(tput setaf 1)✖ %s$(tput sgr0)\n" "$@"
}

# Warning logging
e_warning() {
    printf "$(tput setaf 136)! %s$(tput sgr0)\n" "$@"
}


# ------------------------------------------------------------------------------
# | Utils                                                                      |
# ------------------------------------------------------------------------------

# Test whether a command exists
type_exists() {
    if [ $(type -P $1) ]; then
      return 0
    fi
    return 1
}

# Test whether a directory exists
dir_exists() {
    if [ $(-d $1) ]; then
      return 0
    fi
    return 1
}

# Normalize image names
normalize() {
    rename -v 'y/A-Z/a-z/' *.png
    rename -v 's/ /-/g' *.png
}
