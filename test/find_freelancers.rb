require 'test/unit'
require_relative '../features/support/env'

class TestFindFreelancers < Test::Unit::TestCase
  def test_change_search_contexts
    UpWork::MainPage.new
  end
end
