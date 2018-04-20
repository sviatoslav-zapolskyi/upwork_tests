Given(/^main page$/) do
  visit '/'
end

When(/^find freelancers by (.*)$/) do |keyword|
  find('span.glyphicon.air-icon-search').click
  find('a[data-qa="freelancer_value"]').click
  fill_in(placeholder: 'Find Freelancers', with: keyword).send_keys :enter
end

And(/^read 1st page of found freelancers$/) do

  freelancers = []

  all('section.air-card-hover.air-card-hover-escape.air-card-hover_tile').each do |section|
    freelancers << { name: section.find('a.freelancer-tile-name'),
                   title: section.find('h4.freelancer-tile-title'),
                   # description: section.find('div.col-xs-12#div')['data-profile-description']
    }
  end

  Cucumber.logger.info '------------------------------------------------------------'
  Cucumber.logger.info freelancers

  sleep 500
end

Then(/^(.*) is contained in each found freelancer$/) do |keyword|
  pending
end

When(/^open random freelancers profile$/) do
  pending
end

Then(/^opened freelancers profile matches to one from found freelancers$/) do
  pending
end

And(/^(.*) is contained in opened freelancer$/) do |keyword|
  pending
end
