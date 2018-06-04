class UpWork
  module Title
    include Capybara::DSL

    def search(keyword)
      find(selector :search_input).send_keys(keyword).send_keys(:enter)
      SearchResults.new
    end

    def search_context
      find(selector :search_input)[:placeholder]
    end

    def search_context=(context)
      unless find(selector :search_input)[:placeholder] == context
        find(selector :magnifying_glass).click
        find(selector :search_context).find('a', text: context).click
      end
    end

    private

    def selector(selector_name)
      case selector_name
        when :search_input then 'input[id="q"]'
        when :search_result_list then 'section.air-card-hover.air-card-hover-escape.air-card-hover_tile'
        when :search_context then 'div.form-group.dropdown[eo-dropdown]'
        when :magnifying_glass then 'span.glyphicon.air-icon-search'
      end
    end
  end
end
