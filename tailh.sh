#!/bin/bash

usage() {
  echo "Usage: $0 [-o outfile] URL"
}

_outfile=tailh.out
_logfile=/dev/null
while getopts "o:O:" opt
do
  case $opt in
    O) _outfile=$OPTARG
      ;;
    o) _logile=$OPTARG
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

echo "Downloading from $_url; outfile = $_outfile; logfile = $_logfile"
while [ true ]
do
  wget -c -O $_outfile -o $_logfile $_url
  if [ $? -ne 0 ]; then
    exit
  fi
done
