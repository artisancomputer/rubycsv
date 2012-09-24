# rubycsv

Convert CSV files to arbitrary formats via erb-style templates and lookups.

Basically, it reads in a CSV file, and then evaluates the ERB template on a per-line basis, using the header line to index the lines. 

This allows additional per-input file logic in the conversion, and regex-based lookup tables in the templates.

This was originally created to use with [ledger](http://ledger-cli.org) files, but can process any arbitrary CSV file into other formats.  It was inspired in part by [hledger](http://hledger.org)'s CSV conversion logic.

## Usage

rubycsv.rb templatefile source_csv > outputfile
