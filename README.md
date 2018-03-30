# tailh
Tail a file over http.

The script uses wget to continuosly download a file from a URL and writes it a local file. The local file can be `tail -f`-ed.

## Usage
Download the scipt to your machine. Add a symlink to the script using `ln -s` inside one of your `bin` directories in your `PATH` so that you can run the script as a command. After that you run

    $ tailh [-O outfile] [-o logfile] [-v] URL

While this is running, do 

    $ tail -f outfile
    
to view the contents.

### Options
`-O outfile` 

The downloaded contents will be written to `outfile`. This is passed on to the `-O file` argument for `wget`.

If not provided, `out/tailh.out` will be used.

*`tailh` uses `wget` with `-c -a` arguments, so that the download is
continuously done and the output file is appended. `wget` uses the
output file's size as the offset to continue the download. So for new
downloads, make sure a new output file is used.*

Refer the *-O file* section in [wget documentation](https://www.gnu.org/software/wget/manual/wget.html#Download-Options) for more info.

`-o logfile` 

Logs all messages to `logfile`. Defaults to `/dev/null`,
or `/dev/stdout` if `-v` option is passed

`-v` 

for verbosity
