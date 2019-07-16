is_array() {
    local VARNAME=("$@")
    if [[ "$(declare -p VARNAME)" =~ "declare -a" ]]; then
        return 0
    else
        return 1
    fi
}