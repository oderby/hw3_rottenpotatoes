# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  @rows = 0
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
    @rows += 1
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  reg = /#{e1}.*#{e2}/m
  page.body.should =~ reg
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  s = "check"
  if uncheck
    s = "uncheck"
  end
  rating_list.split(", ").each do |rating|
    step %Q{I #{s} "ratings_#{rating}"}
  end
end

Then /I should see all of the movies/ do
  @rows.should == page.body.scan(/<tr>\n<td>/).length
end
