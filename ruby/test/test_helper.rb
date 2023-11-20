require 'simplecov'

if ENV["COVERAGE"]
  SimpleCov.start do
    add_filter %r{^/ruby/test/}
    add_filter %r{^/ruby/tmp/}
    coverage_dir File.join(__dir__, "../coverage")
  end
end

require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/task_master"
