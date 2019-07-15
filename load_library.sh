GIT_REPO="https://raw.githubusercontent.com/satinjeet/shell_utilities/master/"

echo ">> Curl command is expectected to on this system."
cul=$(which curl)

if [ "$?" == "1" ];
then
    echo ">> Curl not found."
    exit 1
fi

load_lib() {
    SHOULD_I_CURL="yes"
    NAME=""

    if [ $1 == "-a" ];
    then
        FILE_PATH="$2.sh"
        SHOULD_I_CURL="no"
        NAME="$2.sh"
    elif [ $1 == "-u" ];
    then
        FILE_PATH="$2.sh"
        NAME="$2.sh"
    else
        FILE_PATH="$GIT_REPO$1.sh"
        NAME="$1.sh"
    fi
    
    if [ $SHOULD_I_CURL == "yes" ];
    then
        echo ">> Obtaining module \"$NAME\" ~ $FILE_PATH."
        $(curl -kL "$FILE_PATH" > /tmp/$NAME)

        if [ "$?" == "1" ];
        then
            echo ">> Curl: Failed to obtain module \"$NAME\""
            exit 1
        fi
    else
        mv $FILE_PATH /tmp/$NAME
    fi

    source /tmp/$NAME
}

load_lib arrow_key_detection

echo $KEY_LEFT
echo $KEY_RIGHT
echo $KEY_UP
echo $KEY_DOWN
echo $KEY_ENTER