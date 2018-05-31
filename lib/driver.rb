require "selenium-webdriver"

module UpWork
  module Driver

    TIMEOUT = 30_000

    @@driver = Selenium::WebDriver.for :firefox

    def self.driver
      @@driver
    end


    attr_accessor :element

    def visit(uri)
      driver.navigate.to base_url + uri
      self
    end

    def find(css)
      self.element = driver.find_element(:css, css)
      self
    end

    def send_keys(arg)
      element.send_keys(arg)
      self
    end

    def click
      element.click
      self
    end

    def all(css)
      driver.find_elements(:css, css).map { |e| Page.new e }
    end

    def text
      element.text
    end

    def wait_all(css)
      finish_at = Time.now.to_ms + TIMEOUT
      found = false
      while finish_at > Time.now.to_ms
        found = all(css).any?
        break if found
        sleep 1.0 / 2.0
      end

      raise "Failed to find css selector: #{css} for a #{TIMEOUT} ms" unless found
      self
    end

    def driver
      @@driver
    end

    def base_url
      'https://www.upwork.com'
    end

    def [](key)
      self.element[key.to_s]
    end
  end

  class Page
    include Driver

    def initialize(element)
      self.element = element
    end

  end
end

class Time
  def to_ms
    (self.to_f * 1000.0).to_i
  end
end
