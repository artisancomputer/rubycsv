$erb_template = <<END
<%= csvrow["FullName"] %>, <%= /(.*)\s/.match(csvrow["FullName"])[1] %>,<%= csvrow["FullAddress"].to_s.gsub("\n",",") %>,
END
