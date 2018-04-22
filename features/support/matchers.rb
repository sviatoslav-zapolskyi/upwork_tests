require 'rspec/expectations'

RSpec::Matchers.define :key_include do |expected|
  match do |actual|
    actual.select do |_, val|
      val = val.join if val.kind_of?(Array)
      val.downcase.include? expected.downcase
    end.any?
  end

  failure_message do |actual|
    "expected that actual:\n #{actual}\n would include expected:\n#{expected}\n"
  end
end

RSpec::Matchers.define :match_profile do |expected|
  match do |actual|
    actual.select do |key, val|
      if val.kind_of?(Array)
        (expected[key] - val).any?
      else
        !val.downcase.include? expected[key].downcase
      end
    end.any?
  end

  failure_message do |actual|
    "expected that actual:\n #{actual}\n would include expected:\n#{expected}\n"
  end
end
