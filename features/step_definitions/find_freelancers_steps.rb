Given(/^main page$/) do
  @page = UpWork::MainPage.new
end

When(/^find (freelancers|jobs) by (.*)$/) do |context, keyword|
  step %{change search context to 'Find #{context.capitalize}'}
  @page = @page.search keyword
end

And(/^read 1st page of found freelancers$/) do
  @freelancers = @page.data
end

Then(/^(.*) is contained in each found freelancer$/) do |keyword|
  @freelancers.each do |freelancer|
    expect(freelancer).to key_include(keyword)
  end
end

When(/^open random freelancers profile$/) do
  @page = @page.openSampleProfile
end

Then(/^opened freelancers profile matches to one from found freelancers$/) do
  expect(@page.data).to match_profile(@freelancers.find { |f| f[:name] == @page.data[:name] })
end

And(/^(.*) is contained in opened freelancer$/) do |keyword|
  expect(@page.data).to key_include(keyword)
end

When(/^change search context to '(Find Freelancers|Find Jobs)'$/) do |context|
  @page.search_context= context
end

Then(/^selected search context is '(Find Freelancers|Find Jobs)'$/) do |context|
  expect(@page.search_context).to eq(context)
end
