require 'rubygems'
require 'spec'
require 'active_support'
require 'active_record'
require File.dirname(__FILE__) + '/../lib/trusted_params.rb'

Spec::Runner.configure do |config|
  config.mock_with :rr
end

class MockedModel < ActiveRecord::Base
  
  include TrustedParams::ActiveRecordAdditions
  
  class_inheritable_hash :paginate_options
  
  def self.paginate(options)
    self.paginate_options = options
  end
  
  def self.add_column(name, column_type = :string)
    returning ActiveRecord::ConnectionAdapters::Column.new(name, nil) do |column|
      def column.type
        column_type
      end
      @columns ||= []
      @columns << column
    end
  end
  
  def self.reset_columns
    @columns = []
  end
  
  def self.columns
    @columns || []
  end
  
  def self.columns_hash
    columns.index_by{|c| c.name.to_s}
  end
  
  def self.inspect
    "Model Mock"
  end
  
  def self.table_name
    'mocked_models'
  end
end
