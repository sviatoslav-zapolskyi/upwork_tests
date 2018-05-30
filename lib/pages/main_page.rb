module UpWork
  class MainPage
    include UpWork::Driver
    include UpWork::Title

    def initialize
      visit '/'
    end
  end
end
