require_relative '../features/support/env'
require 'minitest/autorun'

module Upwork
  module Matchers
    def key_include(expected, actual)
      actual.select do |_, val|
        val = val.join if val.kind_of?(Array)
        val.downcase.include? expected.downcase
      end.any?
    end

    def match_profile(expected, actual)
      actual.select do |key, val|
        if val.kind_of?(Array)
          (expected[key] - val).any?
        else
          !val.downcase.include? expected[key].downcase
        end
      end.any?
    end
  end

  class FindFreelancersTest < Minitest::Unit::TestCase

    KEYWORD = 'ruby'

    attr_accessor :page

    def setup
      @page = UpWork::MainPage.new
    end

    def test_find_freelancer
      page.search_context = 'Find Freelancers'
      search_results_page = page.search KEYWORD

      freelancers = search_results_page.data
      freelancers.each do |freelancer|
        assert key_include(freelancer, KEYWORD)
      end

      freelancer_profile_page = search_results_page.openSampleProfile
      freelancer = freelancer_profile_page.data
      expect(freelancer).to match_profile(freelancers.find { |f| f[:name] == freelancer[:name] })

      assert match_profile(freelancer_profile_page.data,)
      assert key_include(freelancer_profile_page.data, KEYWORD)
    end

    #
    # def test_change_search_contexts
    #   ['Find Jobs', 'Find Freelancers', 'Find Jobs'].each do |search_context|
    #     page.search_context = search_context
    #     assert page.search_context.eql?(search_context)
    #   end
    # end

    def teardown
      UpWork::Driver.driver.quit
    end
  end
end
