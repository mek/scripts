#!/bin/sh

tmp=${TMPDIR:="/tmp"}
prog=`basename $0`

# procedures
Err() { 
	echo 1>&2 "$*" 
}

Usage() { 
	Err "usage:$*"
	exit 2
}

Fatal() {
	Err "fatal:$*"
	exit 1
}

case $# in
0|1)	Usage "$prog arg arg [args]" ;;
esac

file=$1; shift
test -f $file || Fatal "$progname:$file does not exists"
	
new=$tmp/overwr1.$$ ; old=$tmp/overwr2.$$
trap 'rm -f $new $old; exit 1' 1 2 15

if "$@" >$new
then
	cp $file $old
	trap '' 1 2 15
	cp $new $file
else
	Fatal "overwrite: $1 failed, $file unchanged" 
fi
rm -rf $new $old
