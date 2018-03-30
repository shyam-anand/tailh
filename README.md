# tailh
Tail a file over http

#### Usage
  $ tailh [-O outfile] [-o logfile] [-v] URL

`outfile` is the path to the file to which the downloaded contents will
be written. If not provided, `out/tailh.out` will be used.

*Note* tailh uses `wget` with `-c -a` arguments, so that the download is
continuously done and the output file is appended. *wget* uses the
output file's size as the offset to continue the download. So for new
downloads, make sure a new output file is used.

`logfile` is where the output will be logged. Defaults to `/dev/null`,
or `/dev/stdout` if `-v` option is passed

`-v` for verbosity
