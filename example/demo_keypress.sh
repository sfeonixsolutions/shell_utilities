# $(curl -skL "https://raw.githubusercontent.com/satinjeet/shell_utilities/master/load_library.sh?$(date +%s)" > /tmp/load_library.sh)

source $PWD/load_library.sh

# Load required libraries for the menu.
# Load colors
load_lib -a $PWD/colors colors
# Load keypress detection
load_lib -a $PWD/arrow_key_detection arrow_key_detection


KEY=`read_arrow_key`
echo $KEY
