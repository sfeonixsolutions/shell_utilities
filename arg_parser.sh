
echo "
----------------------------------------------------------------------------------------------------------
Please read https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f for a detailed explanation.
----------------------------------------------------------------------------------------------------------
"

A_FLAGS=()
A_VALS=()

parse_args() {
    PARAMS=""
    while (( "$#" )); do
        case "$1" in
            -*|--*=) # unsupported flags
                if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                    A_FLAGS+=("$1")
                    A_VALS+=("$2")
                    shift 2
                else
                    A_FLAGS+=("$1")
                    A_VALS+=("-")
                    shift
                fi
            ;;
            *) # preserve positional arguments
                PARAMS="$PARAMS $1"
                shift
            ;;
        esac
    done
}

flag_set() {
    FLAG_FOUND=0
    for i in "${!A_FLAGS[@]}"; do
        if [[ "${A_FLAGS[$i]}" = "$1" ]]; then
            FLAG_FOUND=1
        fi
    done

    if [ $FLAG_FOUND -eq 1 ]; then
        echo "yes"
    else
        echo "no"
    fi
}

get_arg() {
    DEF_V=""
    if [ -n "$3" ]; then
        DEF_V="$3"
    elif [ -z "$3" ] && [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        DEF_V="$2"
    fi

    for i in "${!A_FLAGS[@]}"; do
        if [[ "${A_FLAGS[$i]}" = "$1" || "${A_FLAGS[$i]}" = "$2" ]]; then
            DEF_V="${A_VALS[$i]}"
            break
        fi
    done

    echo "$DEF_V"
}

get_params() {
    echo "$PARAMS"
}