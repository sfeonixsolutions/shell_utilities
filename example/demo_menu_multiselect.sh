# $(curl -skL "https://raw.githubusercontent.com/satinjeet/shell_utilities/master/load_library.sh?$(date +%s)" > /tmp/load_library.sh)

source $PWD/load_library.sh

# Load required libraries for the menu.
# Load colors
load_lib -a $PWD/colors colors
# Load keypress detection
load_lib -a $PWD/arrow_key_detection arrow_key_detection
# load validators
load_lib -a $PWD/validators validators
# load menu library
load_lib -a $PWD/select_multiple_menu select_multiple_menu

MENU_SELECTED_OPTIONS=()

options=('Option 1' 'Option 2' 'Option 3' 'Option 4' 'Option 5')
menu_select_multiple "${options[@]}"

echo "${MENU_SELECTED_OPTIONS[@]}"

# echo "${options[$selected_option]}"