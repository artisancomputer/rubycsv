$erb_template = <<END
<%= clean_date(csvrow['Date'],"%Y/%m/%d") %> Savings <%= csvrow['Type'] %>, <%= clean_text(csvrow['Description']) %> 
    ; CSV "<%= $csv_filename %>"
    ACS:Accounts:Savings  $<%= clean_money(csvrow['Amount']) %>
    <%= tablematch($categories,clean_text(csvrow['Description'])) %>

END

$categories = [["Unknown", "DEFAULT"],
    ["Chase:Interest", "INTEREST PAYMENT"],
    ["ACS:Expenses:Fees:Chase", "SERVICE FEE"],
    ["Transfer:Checking_Savings", "Online Transfer", ".* Online Transfer To Chk", "ODP Transfer To Checking"]] 
    
