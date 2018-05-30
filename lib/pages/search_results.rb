module UpWork
  class SearchResults
    include UpWork::Driver
    include UpWork::Title

    attr_accessor :data

    def initialize
      wait_all(selector :description)

      @data = all(selector :search_result_list).map do |f|
        str = f.all('*[data-ng-click^="linkClicked($event"]').first[:'data-ng-click']
        json = JSON.parse(str.slice(str.index('{')..str.rindex('}')), symbolize_names: true)

        { name: json[:shortName],
          title: json[:title],
          description: json[:description],
          skills: json[:skills].map { |s| s[:skill][:name] },
          url: json[:url]
        }
      end
    end

    def openProfile(name)
      visit(data.find { |p| p[:name] == name }[:url])
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
