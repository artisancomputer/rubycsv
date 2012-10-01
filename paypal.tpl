$erb_template = <<END
<% transcur = tablematch($currency,csvrow['Currency']) + " "%>
<% if (((csvrow['Status'] == "Completed") || (csvrow['Status'] == "Refunded") || (csvrow['Status'] == "Reversed")) && (csvrow['Type'] != "Shopping Cart Item")) %>
<%= clean_date(csvrow['Date']) %> Paypal <%= clean_text(csvrow['Name'] + ' ' + csvrow['To Email Address'] + ' ' + csvrow['Item Title']) %> ID: <%= csvrow['Transaction ID'] %>, <%= csvrow['Type'] %> 
    ; CSV "<%= $csv_filename %>", line: <%= $line %> 
<% if csvrow['Fee'] != "0.00" %>
    Business:Expenses:Fees:Paypal  <%= transcur + clean_money(csvrow['Fee']) %>
<% end %>
<% if csvrow['Type'] == "Add Funds from a Bank Account" %>
    Accounts:Paypal  <%= transcur + clean_money(csvrow['Net']) %>
    Transfer:Checking_Paypal 
<% else %>
    Accounts:Paypal  <%= transcur + clean_money(csvrow['Gross']) %>
    <%= tablematch($categories, clean_text(csvrow['Name'] + ' ' + csvrow['To Email Address'] + ' ' + csvrow['From Email Address'])) %>
<% end %>

<% end %>
END

$currency = [["Unknown", "DEFAULT"],
    ["CAN", "CAN"], 
    ["EUR", "€", "EUR"],
    ["$", "$", "USD", "US"]]

$categories = [["Unknown", "DEFAULT"],
    [ "Accounts:Paypal", 
        "From U.S.", "To Euro"],
    [ "Business:Assets:Supplies", 
      "dealextreme.com"]]

