$erb_template = <<END
<%= clean_date(csvrow['Date']) %> Savings <%= csvrow['Type'] %>, <%= clean_text(csvrow['Description']) %> 
    ; CSV "<%= $csv_filename %>", line: <%= $line %> 
    Business:Accounts:Savings  $<%= clean_money(csvrow['Amount']) %>
    <%= tablematch($categories,clean_text(csvrow['Description'])) %>

END

$categories = [["Unknown", "DEFAULT"],
    ["Chase:Interest", "INTEREST PAYMENT"],
    ["Business:Expenses:Fees:Chase", "SERVICE FEE"],
    ["Transfer:Checking_Savings", "Online Transfer"]] 
    
