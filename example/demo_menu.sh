# $(curl -skL "https://raw.githubusercontent.com/satinjeet/shell_utilities/master/load_library.sh?$(date +%s)" > /tmp/load_library.sh)

source $PWD/load_library.sh

load_lib -a $PWD/colors colors
load_lib -a $PWD/arrow_key_detection arrow_key_detection
load_lib -a $PWD/select_one_menu select_one_menu
load_lib -a $PWD/validators validators

options=('Option 1' 'Option 2' 'Option 3' 'Option 4' 'Option 5')
menu_select_one "${options[@]}"
selected_option=$?

echo "${options[$selected_option]}"