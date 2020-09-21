source $PWD/load_library.sh

load_lib -a $PWD/arg_parser arg_parser

parse_args $@

p1=$(flag_set -a)
p2=$(flag_set -n)

v1=$(get_arg -b)
v2=$(get_arg --key -k)

d1=$(get_arg -c)
d2=$(get_arg -c default)
d3=$(get_arg -c --compress)
d4=$(get_arg -c --compress default)

params=$(get_params)

echo "\n-a is set? $p1"
echo "\n-n is set? $p2"

echo "\nvalue for -b: $v1"
echo "\nvalue for --key|-k: $v2"

echo "\ndefault value for -c: $d1"
echo "\ndefault value for -c default: $d2"
echo "\ndefault value for -c --compress: $d3"
echo "\ndefault value for -c --compress default: $d4"

echo "\nParams: $params"
