
# Make sure that we include latest load_library file
source /dev/stdin <<< "$(curl -skL https://raw.githubusercontent.com/satinjeet/shell_utilities/master/load_library.sh\?$(date +%s))"

# source /tmp/load_library.sh

# Load required libraries for the menu.
# Load colors
load_lib colors
# Load keypress detection
load_lib arrow_key_detection
# load validators
load_lib validators
# load menu library
load_lib select_one_menu

options=('Option 1' 'Option 2' 'Option 3' 'Option 4' 'Option 5')
menu_select_one "${options[@]}"
selected_option=$?

echo "${options[$selected_option]}"