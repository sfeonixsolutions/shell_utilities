source $PWD/load_library.sh

load_lib -a $PWD/arg_parser arg_parser

parse_args $@

p1=$(flag_set -a)
p2=$(flag_set -n)

v1=$(get_arg -b)
v2=$(get_arg -c)

params=$(get_params)

echo "-a is set? $p1" 
echo "-n is set? $p2" 

echo "value for -b: $v1"
echo "value for -c: $v2"