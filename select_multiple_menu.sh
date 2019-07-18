# Expect a result variable
# MENU_SELECTED_OPTIONS
menu_select_multiple() {
    echo ""

    # MENU_SELECTED_OPTIONS=${MENU_SELECTED_OPTIONS:-()}
    # TODO fix validation.
    # is_array "${MENU_SELECTED_OPTIONS[@]}"
    # if [ $? -gt 0 ]; then
    #     echo "MENU_SELECTED_OPTIONS needs to be set for this menu to work.";
    #     exit 1;
    # fi

    local MENU_OPTIONS=("$@")
    local MENU_HIGHLIGHTED=0
    local loop_counter=0
    
    is_array "${MENU_OPTIONS[@]}"
    if [ $? -gt 0 ]; then
        echo "Expected the argument to be an array of string options, something is not right here..."
        exit 1
    fi
    
    echo "
Menu:
 - ↑↓ move between options.
 - → Select the option.
 - ← De-Select the option.
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
            if [[ "${MENU_SELECTED_OPTIONS[$NUM]}" != "" ]];then
                echo "${FONT_BOLD}(X) ${COLOR_GREEN}${MENU_OPTIONS[$i]}${FONT_NORMAL}"
            elif [[ "$MENU_HIGHLIGHTED" == "$NUM" ]];then
                echo "${FONT_BOLD}( ) ${COLOR_BLUE}${MENU_OPTIONS[$i]}${FONT_NORMAL}"
            else
                echo "( ) ${MENU_OPTIONS[$i]}"
            fi
        done

        KEY=`read_arrow_key`
        KEY=$(sed -e "s/[^A-Z']//g" -e 's/ \+/ /' <<< $KEY)
        KEY=$(echo "$KEY" | cut -c2-10)

        if [[ "$KEY" == "$KEY_UP" ]]; then
            ((MENU_HIGHLIGHTED--))
        elif [[ "$KEY" == "$KEY_DOWN" ]]; then
            ((MENU_HIGHLIGHTED++))
        elif [[ "$KEY" == "$KEY_LEFT" ]]; then
            unset MENU_SELECTED_OPTIONS[$MENU_HIGHLIGHTED]
        elif [[ "$KEY" == "$KEY_RIGHT" ]]; then
            if [ $MENU_HIGHLIGHTED -ge 1 -a $MENU_HIGHLIGHTED -le ${#MENU_OPTIONS[@]} ]; then
                MENU_SELECTED_OPTIONS[$MENU_HIGHLIGHTED]=$((MENU_HIGHLIGHTED-1))
            fi
        else
            break
        fi

        if [ $MENU_HIGHLIGHTED -le 1 ]; then
            MENU_HIGHLIGHTED=1
        fi
        if [ $MENU_HIGHLIGHTED -ge ${#MENU_OPTIONS[@]} ]; then
            MENU_HIGHLIGHTED=${#MENU_OPTIONS[@]}
        fi

        (( loop_counter++ ))
    done
}

