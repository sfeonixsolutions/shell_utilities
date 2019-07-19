GIT_REPO="https://raw.githubusercontent.com/satinjeet/shell_utilities/master/"
CLEARING_LIST=""

echo ">> Curl command is expectected to on this system."
cul=$(which curl)

if [ "$?" == "1" ];
then
    echo ">> Curl not found."
    exit 1
fi

debug_echo() {
    if [ "$DEBUG_MODE" == "yes" ]; then
        echo "$1"
    fi
}

load_lib() {
    local FONT_BOLD_L=$(tput bold)
    local FONT_NORMAL_L=$(tput sgr0)

    DEBUG_MODE="no"
    local MODE_REPO="yes"
    local MODE_ABSOLUTE="no"
    local MODE_URL="no"
    local MODE_FORCE="no"

    local ALL_ARGS=("$@")
    local USEFUL_ARGS=()

    for i in "${!ALL_ARGS[@]}"
    do
        local V_V="${ALL_ARGS[$i]}"
        if [ "$V_V" == "-d" ]; then DEBUG_MODE="yes"; unset ALL_ARGS[$i]
        elif [ "$V_V" == "-a" ]; then MODE_ABSOLUTE="yes"; unset ALL_ARGS[$i]
        elif [ "$V_V" == "-u" ]; then MODE_URL="yes"; unset ALL_ARGS[$i]
        elif [ "$V_V" == "-f" ]; then MODE_FORCE="yes"; unset ALL_ARGS[$i]
        else USEFUL_ARGS+=($V_V)
        fi
    done

    if [[ "$MODE_ABSOLUTE" == "yes" || "$MODE_URL" == "yes" ]]; then
        MODE_REPO="no"
    fi

    debug_echo "UA >> ${USEFUL_ARGS[@]}"

    if [ "$MODE_ABSOLUTE" == "yes" ];
    then
        if [[ "${USEFUL_ARGS[1]}" == "" ]]; then
            echo ">> Failed !!\\n>> For loaded modules with -a option, please prodvide name for the script \"${FONT_BOLD_L}load_lib -a <path>/module module${FONT_NORMAL_L}\""
            exit 1
        fi
        FILE_PATH="${USEFUL_ARGS[0]}.sh"
        NAME="${USEFUL_ARGS[1]}.sh"
    elif [ "$MODE_URL" == "yes" ];
    then
        if [[ "${USEFUL_ARGS[1]}" == "" ]]; then
            echo ">> Failed!!.\\n>> For loaded modules with -u option, please prodvide name for the script ${FONT_BOLD_L}load_lib -a <path>/module module${FONT_NORMAL_L}"
            exit 1
        fi
        FILE_PATH="${USEFUL_ARGS[0]}.sh"
        NAME="${USEFUL_ARGS[1]}.sh"
    elif [ "$MODE_REPO" == "yes" ]; then
        FILE_PATH="$GIT_REPO${USEFUL_ARGS[0]}.sh"
        NAME="${USEFUL_ARGS[0]}.sh"
    fi
    
    if [[ "$MODE_REPO" == "yes" || "$MODE_URL" == "yes" ]]; then
        if [[ -f /tmp/$NAME && "$MODE_FORCE" == "no" ]]; then
            echo ">> Using cached module \"$NAME\" ~ $FILE_PATH."
        else
            if [ "$MODE_FORCE" == "yes" ]; then f_f="${FONT_BOLD_L}(-f)"; fi
            echo ">>$f_f Obtaining module \"$NAME\" ~ $FILE_PATH.${FONT_NORMAL_L}"
            $(curl -skL "$FILE_PATH?$(date +%s)" > /tmp/$NAME)

            if [ "$?" == "1" ];
            then
                echo ">> Curl: Failed to obtain module \"$NAME\""
                exit 1
            fi
        fi
        
    else
        echo ">> Obtaining module \"$NAME\" ~ $FILE_PATH."
        cp $FILE_PATH /tmp/$NAME
    fi

    source /tmp/$NAME
    # CLEARING_LIST="$CLEARING_LIST /tmp/$NAME"
}
