$erb_template = <<END
<%= clean_date(csvrow['Date']) %> Square <%= csvrow['Transaction Type'] %>, <%= csvrow['Payment Method'] %>, <%= csvrow['Card Brand'] %> <%= clean_num(csvrow['Card Number']) %> ID: <%= csvrow['Payment ID'] %> 
    ; CSV "<%= $csv_filename %>", line: <%= $line %> 
    ; Payment URL: <%= csvrow['Details'] %> 
    Transfer:Customers_Square  -$<%= clean_money(csvrow['Total']) %>
    Business:Expenses:Fees:Square  $<%= clean_money(csvrow['Fee']) %>
    Transfer:Checking_Square  $<%= clean_money(csvrow['Net']) %>

END
