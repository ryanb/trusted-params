require 'trusted_params'

ActiveRecord::Base.class_eval do
  include TrustedParams::ActiveRecordAdditions
end
