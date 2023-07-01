# Various scripts I have carried around from job to job

* [gres](gres) - from the Sed and Awk book. 

``` shell
gres pattern replacement file 
```

Uses sed to do replacement in a file. 

Basically runs sed "s/pattern/replacment/" on a file and outputs it to 
standard output.

NOTE: gres only replace the FIRST occurance of pattern in each line.

* [overwrite](overwrite) - from "The UNIX Programming Environment (TUPE)".

``` shell
overwrite file cmd args
```

Over write a file after running cmd on the file. 

Two temp files are created, old and new.

The command and args are run and the output goes to $new. If the command
was successful, the file is copied to $old, $new is copied to file.

Traps are used to clean up the old files if there is an error. 

* [replace](replace) - also from TUPE.

``` shell
replace pattern replacement files
```

Using `gres` and `overwrite`, replace all occurances of `pattern` with `replacement` and `files`.

Overwrite is used to make sure we don't accidently delete a file.

``` shell
$ cp testfiles/hosts testfiles/hosts.orig
$ replace host HOST testfiles/hosts
$ diff testfiles/hosts.orig testfiles/hosts
1c1
< 127.0.0.1	localhost
---
> 127.0.0.1	localHOST
5,6c5,6
< # The following lines are desirable for IPv6 capable hosts
< ::1     localhost ip6-localhost ip6-loopback
---
> # The following lines are desirable for IPv6 capable HOSTs
> ::1     localHOST ip6-localhost ip6-loopback
```

NOTE: gres only replace the FIRST occurance of pattern in each line.

* [c+](c+) and [c-](c-) Add/remove comment hash `#` from the start of a line.

``` shell
c+ < file
c- < file
```

I mainly use these in my editors of choise (sam and acme).

``` shell
$ sam -d gres
 -. gres
1,10p
#!/bin/sh

tmp=${TMPDIR:="/tmp"}
prog=`basename $0`

# procedures
Err() { 
	echo 1>&2 "$*" 
}

1,10 | c+
!
1,10 p 
# #!/bin/sh
# 
# tmp=${TMPDIR:="/tmp"}
# prog=`basename $0`
# 
# # procedures
# Err() { 
# 	echo 1>&2 "$*" 
# }
# 
1,10 | c-
!
1,10 p
#!/bin/sh

tmp=${TMPDIR:="/tmp"}
prog=`basename $0`

# procedures
Err() { 
	echo 1>&2 "$*" 
}
```
