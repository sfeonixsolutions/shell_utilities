source $PWD/load_library.sh

load_lib -a $PWD/arg_parser arg_parser

parse_args $@

p1=$(flag_set -a)
p2=$(flag_set -n)

v1=$(get_arg -b)
v2=$(get_arg -c)
v3=$(get_arg --key -k)

params=$(get_params)

echo "\n-a is set? $p1"
echo "\n-n is set? $p2"

echo "\nvalue for -b: $v1"
echo "\nvalue for -c: $v2"
echo "\nvalue for --key|-k: $v3"

echo "\nParams: $params"