# $(curl -skL "https://raw.githubusercontent.com/satinjeet/shell_utilities/master/load_library.sh?$(date +%s)" > /tmp/load_library.sh)

source $PWD/load_library.sh

load_lib -a $PWD/colors colors
load_lib -a $PWD/arrow_key_detection arrow_key_detection

MENU_SELECTED=0
MENU_OPTIONS=(
    "Something"
    "Else"
    "Foo"
    "Bar"
)

while true
do
    for i in "${!MENU_OPTIONS[@]}";do printf '\e[A\e[K'; done

    for i in "${!MENU_OPTIONS[@]}"
    do
        NUM=$((i+1))
        if [[ "$MENU_SELECTED" == "$NUM" ]];then
            echo "> ${MENU_OPTIONS[$i]}"
        else
            echo "$NUM ${MENU_OPTIONS[$i]}"
        fi
    done

    KEY=`read_arrow_key`
    KEY=$(sed -e "s/[^A-Z']//g" -e 's/ \+/ /' <<< $KEY)
    KEY=$(echo "$KEY" | cut -c2-10)

    if [[ "$KEY" == "$KEY_UP" ]]; then
        ((MENU_SELECTED--))
    elif [[ "$KEY" == "$KEY_DOWN" ]]; then
        ((MENU_SELECTED++))
    else
        break
    fi

    if [ $MENU_SELECTED -le 0 ]; then
        MENU_SELECTED=1
    fi
    if [ $MENU_SELECTED -ge ${#MENU_OPTIONS[@]} ]; then
        MENU_SELECTED=${#MENU_OPTIONS[@]}
    fi
done

echo $MENU_SELECTED