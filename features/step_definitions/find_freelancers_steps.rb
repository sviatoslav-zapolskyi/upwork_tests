Given(/^main page$/) do
  visit '/'
end

When(/^find (freelancers|jobs) by (.*)$/) do |context, keyword|
  step %{change search context to 'Find #{context.capitalize}'}
  find('input[id="q"]').send_keys(keyword).send_keys(:enter)
  all('p.p-0-left.m-0.freelancer-tile-description')
end

And(/^read 1st page of found freelancers$/) do
  @freelancers = all('section.air-card-hover.air-card-hover-escape.air-card-hover_tile').map do |f|
    next if JSON.parse(f[:'data-log-data'])['contractor_type'] != 'freelancer'

    { name: f.find('a.freelancer-tile-name').text,
      title: f.find('h4.freelancer-tile-title').text,
      description: f.find('p.p-0-left.m-0.freelancer-tile-description').text,
      skills: f.all('a.o-tag-skill.m-sm-top.m-0-bottom').map(&:text)
    }
  end.compact
end

Then(/^(.*) is contained in each found freelancer$/) do |keyword|
  @freelancers.each do |freelancer|
    expect(freelancer).to key_include(keyword)
  end
end

When(/^open random freelancers profile$/) do
  @selected_name = @freelancers.sample[:name]
  all('a.freelancer-tile-name').find { |name| name.text == @selected_name }.click
  all('a.o-tag-skill')
  @opened_freelancers_profile = {
    name: find('span.ng-binding[itemprop="name"][data-ng-click]').text,
    title: find('h3.m-0-top.m-sm-bottom[data-ng-if="vm.vpd.profile.title"]').text,
    description: find('p[itemprop="description"][o-words-threshold="80"]').text,
    skills: all('a.o-tag-skill').map(&:text)
  }
end

Then(/^opened freelancers profile matches to one from found freelancers$/) do
  expect(@opened_freelancers_profile).to match_profile(@freelancers.find { |f| f[:name] == @selected_name })
end

And(/^(.*) is contained in opened freelancer$/) do |keyword|
  expect(@opened_freelancers_profile).to key_include(keyword)
end

When(/^change search context to '(Find Freelancers|Find Jobs)'$/) do |context|
  unless find('input[id="q"]')[:placeholder] == context
    find('span.glyphicon.air-icon-search').click
    find('div.dropdown[eo-dropdown]').find('a', text: context).click
  end
end

Then(/^selected search context is '(Find Freelancers|Find Jobs)'$/) do |context|
  expect(find('input[id="q"]')[:placeholder]).to eq(context)
end
