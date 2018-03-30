#!/bin/bash

usage() {
  echo "Usage: tailh [-O outfile] [-o logfile] [-v] URL"
}

check_file_exists() {
  file=$1
  # Check if file exists
  if [ ! -f "$file" ]; then
    dir=$(dirname $file); # Get the base directory of the file
    # Check if the directory exists
    if [ ! -d $dir ]; then
      mkdir -p $dir;
      if [ $? -ne 0 ]; then
        echo "Failed to create dir '$dir'";
        exit 1;
      fi
    fi

    touch $file;
    if [ $? -ne 0 ]; then
      echo "$file does not exist, and cannot be created";
      exit 1;
    fi
  fi

  # Check if file is writable
  if [ ! -w "$file" ]; then
    echo "$file is not writable"
    exit 1;
  fi
}

_cwd=`pwd`
_outfile=$_cwd/out/tailh.out
_logfile=/usr/local/var/tailh/tailh.log
_logfile_override=false
_verbose=false
while getopts "O:o:v" opt
do
  case $opt in
    O) _outfile=$OPTARG
      ;;
    o) _logfile=$OPTARG
       _logfile_override=true
      ;;
    v) _verbose=true
       if [ $_logfile_override = false ]; then
         _logfile=/dev/stdout
       fi
      ;;
   esac
done

if [ $# -lt 1 ]; then
  usage;
  exit 1;
fi

args=( $@ )
len=${#args[@]}
_url=${args[$len-1]}

if [ -z $_url ]; then
  echo "URL is null"
  usage;
  exit 1;
fi

check_file_exists $_outfile;
check_file_exists $_logfile;

if $_verbose ; then
  echo "URL - $_url"
  echo "Local file - $_outfile"
  if [ $_logfile_override = true ]; then
    echo "Log file $_logfile"
  fi
fi

while [ true ]
do
  wget -c -O $_outfile -o $_logfile $_url
  if [ $? -ne 0 ]; then
    exit
  fi
done
