# Shell Utilities _v: 0.2.0_

This project exposes some useful shell utilities to help writing managed & modular bash scripts.

___

## Utilities
1. load_library
2. colors
3. arrow_key_detection
4. List menu - single selection.
5. List menu - Multiple seletion.
6. Helpers
    - validators

___

### 1. Load Library `load_library.sh`

This script allows you to load another shell script that includes other useful functions or variables. Load library will need to be required by the main script on top. Once loaded, you can now load scripts from URLS or file path easily. By default the load_library will try to get the script from this github repository. Please check examples to see the exact scenarios.

**Syntax**: `load_lib [-a] [-u] <path_to_library>`

**Must Read**: Do not append `.sh` to the script path.

**Usage**<br />
To load the load_library script use
```bash
$(curl -skL "https://raw.githubusercontent.com/satinjeet/shell_utilities/master/load_library.sh?$(date +%s)" | bash)
# OR
$(curl -skL "https://raw.githubusercontent.com/satinjeet/shell_utilities/master/load_library.sh?$(date +%s)" > /tmp/load_library.sh)
source /tmp/load_library.sh


# Using
load_lib <path_to_library>
```

To load a script from this github repository, simple use
```bash
load_lib colors
load_lib arrow_key_detection
```

To load a script from this another URL, use the `-u` flag. `-u` indicates that script does not need to parse the url. 
```bash
load_lib -u <some_url>/colors
load_lib -u <some_url>/arrow_key_detection
```

To load a script from filesystem, use the `-a` flag. `-a` indicates that script does not need to curl for the script. 
```bash
load_lib -a /<directory_path>/colors
load_lib -a <directory_path>/arrow_key_detection
```
___

### 2. Colors `colors.sh`

Provides a handy list of variables with unicodes for various colors & font styles.
___
### 3. Arrow Keypress Detection `arrow_key_detection.sh`

Provides a method to detect if arrow keys were pressed. It is a simple loop, limited right now to detect four arrow keys & an extra case for any other key press. It exposes the method `read_arrow_key` to start the keypress detection & four variables KEY_LEFT, KEY_RIGHT, KEY_UP, KEY_DOWN as return values as well as something to compare the values that are recieved.

The command echoes the result, as well as returns an exit code 0 for successful exit.

**Usage**<br />
```bash
KEY=`read_arrow_key`
echo $KEY

KEY=`read_arrow_key`
if [ "$KEY" == "$KEY_RIGHT" ];then
    echo "Right key was pressed."
fi
```

___

### 4.Menu List - Single Selection

This script easy provides a way to create an interactive menu & return the selected option from the menu. This script uses `colors` & `arrow_key_detection` to handle layout & interaction. **For now the colors & arrow key detection needs to be loaded externally, while load_lib is worked upon**.

The chosen menu option is returned as the exit code. In case of invalid or no selection, the function will return **99**.

```bash
Menu:
 - ↑,← Move up.
 - ↓,→ Move down.
 - ↵ Enter to finish the selection.

1. Option 1
2. Option 2
3. Option 3
4. Option 4
5. Option 5
```

**Usage**
```bash
source <github_url>/load_library.sh

# Load required libraries for the menu.
# Load colors
load_lib colors
# Load keypress detection
load_lib arrow_key_detection
# load validators
load_lib validators
# load menu library
load_lib select_one_menu

# Define menu
options=('Option 1' 'Option 2' 'Option 3' 'Option 4' 'Option 5')

# Create the menu
menu_select_one "${options[@]}"

# get the selected option as return code
selected_option=$?

echo "${options[$selected_option]}"
```
> Output

```bash
Menu:
 - ↑,← Move up.
 - ↓,→ Move down.
 - ↵ Enter to finish the selection.

1. Option 1
2. Option 2
>> Option 3                                 # user chose this option & hit enter
4. Option 4
5. Option 5

Option 3
```
___
### 5.Menu List - Multi Selection

This script easy provides a way to create an interactive menu to select multiple options & exposes the selected options as a global variable `MENU_SELECTED_OPTIONS`.
This script also uses `colors` & `arrow_key_detection` to handle layout & interaction. **For now the colors & arrow key detection needs to be loaded externally, while load_lib is worked upon**.

`MENU_SELECTED_OPTIONS` is exposed after the menu layout is executed. it is an array with indexes of the chosen options. In case of no selection and empty array `()` is returned.

```bash
Menu:
 - ↑↓ move between options.
 - → Select the option.
 - ← De-Select the option.
 - ↵ Enter to finish the selection.

( ) Option 1
( ) Option 2
( ) Option 3
( ) Option 4
( ) Option 5
```

**Usage**
```bash
source <github_url>/load_library.sh

# Load required libraries for the menu.
# Load colors
load_lib colors
# Load keypress detection
load_lib arrow_key_detection
# load validators
load_lib validators
# load menu library
load_lib select_multiple_menu

options=('Option 1' 'Option 2' 'Option 3' 'Option 4' 'Option 5')
menu_select_multiple "${options[@]}"

echo "your selection: "
for s in "${MENU_SELECTED_OPTIONS[@]}"
do
    echo "${options[$s]}"
done

```
> Output

```bash
Menu:
 - ↑↓ move between options.
 - → Select the option.
 - ← De-Select the option.
 - ↵ Enter to finish the selection.

(X) Option 1
( ) Option 2
(X) Option 3
( ) Option 4
( ) Option 5

your selection: 
Option 1
Option 3
```