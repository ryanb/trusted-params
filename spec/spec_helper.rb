require 'rubygems'
require 'spec'
require 'active_support'
require 'active_record'
require File.dirname(__FILE__) + '/../lib/trusted_params.rb'

Spec::Runner.configure do |config|
  config.mock_with :rr
end
