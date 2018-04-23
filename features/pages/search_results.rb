class UpWork
  class SearchResults
    include Capybara::DSL
    include UpWork::Title

    attr_accessor :data

    def initialize
      all(selector :description)

      @data = all(selector :search_result_list).map do |f|
        next if JSON.parse(f[:'data-log-data'])['contractor_type'] != 'freelancer'

        { name: f.find(selector :name).text,
          title: f.find(selector :title).text,
          description: f.find(selector :description).text,
          skills: f.all(selector :skills).map(&:text)
        }
      end.compact
    end

    def openProfile(name)
      all(selector :name).find { |n| n.text == name }.click
      Profile.new
    end

    def openSampleProfile
      openProfile data.sample[:name]
    end

    private

    def selector(selector_name)
      case selector_name
        when :search_result_list then 'section.air-card-hover.air-card-hover-escape.air-card-hover_tile'
        when :name then 'a.freelancer-tile-name'
        when :title then 'h4.freelancer-tile-title'
        when :description then 'p.p-0-left.m-0.freelancer-tile-description'
        when :skills then 'a.o-tag-skill.m-sm-top.m-0-bottom'
      end
    end
  end
end
