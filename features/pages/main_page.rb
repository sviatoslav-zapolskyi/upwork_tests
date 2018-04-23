class UpWork
  class MainPage
    include Capybara::DSL
    include UpWork::Title

    def initialize
      visit '/'
    end
  end
end
