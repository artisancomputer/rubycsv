#!/usr/bin/env ruby

require 'csv'
require 'erb'
require 'date'

# globals
$template_file = ARGV[0]
$csv_filename = ARGV[1]
$template_text = ""
$header_row = []
$line = 0

# evaluate the template in order to get the templates and other variables out
eval(File.read($template_file))
$template_text = $erb_template

# class to bind hash into erb template
class CSVRow
    attr_accessor :csvrow

    def initialize(row)
        @csvrow = Hash.new
        index = 0 
        $header_row.size.times do 
            @csvrow[$header_row[index]] = row[index]
            index +=1;
        end
    end

    def get_binding()
        return binding()
    end
end

# helper functions
def clean_date(text_date) # reformat date in to big endian format
    return Date.parse(text_date).strftime("%Y-%m-%d")
end

def clean_money(text_money) # nuke all but digits, negation, decimal place
    if text_money.nil?
        return ""
    end
    return text_money.gsub(/[^-\d\.]/,'')
end

def clean_num(text_num) # nuke all but digits, negation
    if text_num.nil?
        return ""
    end
    return text_num.gsub(/[^-\d]/,'')
end

def clean_text(text) # get rid of anything that's not a word or space, make multiple spaces single space
    if text.nil?
        return ""
    end
    return text.gsub(/[^\w \]\[\@\.\,\'\"]/,'').gsub(/[ ]+/,' ').strip;
end

# lookup values in arrays.  Table is a 2D array, 
# where the first value is the string returned, 
# and the following are substrings to attempt to match against the value

def tablematch(table, value)
    default = ""

    table.each do |row|
        rowfirst = row.first

        row.slice(1,row.length).each do |item|
            if item == "DEFAULT"  # set the default value
                default = rowfirst
            elsif value.match(/^#{item}/i)
                #print "  val: #{value} matches #{item}, returning #{rowfirst}\n"
                return rowfirst
            end
        end
    end
    return default
end

# parse CSV file

CSV.open($csv_filename,'r') do |row|
    $line += 1 

    if($line == 1) #this is the header row, store to assign as keys on later rows, stripping whitespace
        $header_row = row.collect{|val| val.strip}
    else
        thisrow = CSVRow.new(row)
        #print "line: #{thisrow.csvrow.inspect}\n"
        erbrender = ERB.new($erb_template, nil, '<>')
        puts erbrender.result(thisrow.get_binding)
    end
end


