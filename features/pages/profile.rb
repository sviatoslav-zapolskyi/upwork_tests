class UpWork
  class Profile
    include Capybara::DSL
    include UpWork::Title

    attr_accessor :data

    def initialize

      all(selector :skills)

      @data = {
        name: find(selector :name).text,
        title: find(selector :title).text,
        description: find(selector :description).text,
        skills: all(selector :skills).map(&:text)
      }
    end

    private

    def selector(selector_name)
      case selector_name
        when :name then 'span.ng-binding[itemprop="name"][data-ng-click]'
        when :title then 'h3.m-0-top.m-sm-bottom[data-ng-if="vm.vpd.profile.title"]'
        when :description then 'p[itemprop="description"][o-words-threshold="80"]'
        when :skills then 'span.o-tag-skill,a.o-tag-skill'
      end
    end
  end
end
