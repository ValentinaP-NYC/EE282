#!/usr/bin/env bash
if [ ! $# == 2 ] # $# is the number of command line arguments. This script takes
exactly 2 arguments
then
scriptname=$(basename "$0") # $0 is the full path to the script, basename takes
just the filename part
echo "usage: $scriptname name path" # Print usage if the number of arguments
isn't correct.
exit 1 # Exit
fi
name=$1 # $1 is the project name (first argument)
path=$2 # $2 is location of the project directory (second argument)
mkdir -p $path/$name/code/{analysis,scripts,src,bin} # Curly brackets are similar
to globs, except they can fail
mkdir -p $path/$name/output/{reports,tables,figures}
mkdir -p $path/$name/data/{raw,processed}
find $path/$name -type d -exec touch {}/README.md \; # Using the find program with
the exec option
echo -e "Project $name created at $path.\n"
tree $path/$name
