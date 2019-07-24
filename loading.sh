LOADING_INDEX=0
loading() {
    local loadingIcons=('|' '/' '-' '\')
    echo "${loadingIcons[$LOADING_INDEX]} $1"
    
    LOADING_INDEX=$(( $LOADING_INDEX+1 ))
    if [[ $LOADING_INDEX -ge "${#loadingIcons[@]}" ]]; then
        LOADING_INDEX=0
    fi
    sleep 0.1
    printf '\e[A\e[K'
}

loop_loading() {
    local i=0
    local f=$1
    local final=${f:-10}

    echo "$final < Final"

    while [ $i -le $final ];
    do
        loading "Testing Loading"
        i=$(( $i+1 ))
    done
}