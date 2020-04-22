menu_select_one() {
    echo ""

    local MENU_OPTIONS=("$@")
    local MENU_SELECTED=0
    local loop_counter=0
    [ "$S_MENU_TITLE" == "" ] && S_MENU_TITLE="Menu"

    is_array "${MENU_OPTIONS[@]}"
    if [ $? -gt 0 ]; then
        echo "Expected the argument to be an array of string options, something is not right here..."
        exit 1
    fi
    echo "
$S_MENU_TITLE:
 - ↑,← Move up.
 - ↓,→ Move down.
 - ↵ Enter to finish the selection.
"
    while true
    do
        if [ $loop_counter -gt 0 ]; then
            for i in "${!MENU_OPTIONS[@]}";do printf '\e[A\e[K'; done
        fi

        for i in "${!MENU_OPTIONS[@]}"
        do
            NUM=$((i+1))
            if [[ "$MENU_SELECTED" == "$NUM" ]];then
                echo "${FONT_BOLD}>> ${COLOR_BLUE}${MENU_OPTIONS[$i]}${FONT_NORMAL}"
            else
                echo "$NUM. ${MENU_OPTIONS[$i]}"
            fi
        done

        KEY=`read_arrow_key`
        KEY=$(sed -e "s/[^A-Z']//g" -e 's/ \+/ /' <<< $KEY)
        KEY=$(echo "$KEY" | cut -c2-10)

        if [[ "$KEY" == "$KEY_UP" || "$KEY" == "$KEY_LEFT" ]]; then
            ((MENU_SELECTED--))
        elif [[ "$KEY" == "$KEY_DOWN" || "$KEY" == "$KEY_RIGHT" ]]; then
            ((MENU_SELECTED++))
        else
            break
        fi

        if [ $MENU_SELECTED -le 1 ]; then
            MENU_SELECTED=1
        fi
        if [ $MENU_SELECTED -ge ${#MENU_OPTIONS[@]} ]; then
            MENU_SELECTED=${#MENU_OPTIONS[@]}
        fi

        (( loop_counter++ ))
    done

    echo ""

    if [ $MENU_SELECTED -le 0 ]; then
        return 99
    else
        ((MENU_SELECTED--))
        return $MENU_SELECTED
    fi
}
