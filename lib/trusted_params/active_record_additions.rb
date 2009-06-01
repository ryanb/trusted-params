module TrustedParams
  module ActiveRecordAdditions
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def attr_protected(*args)
        raise "attr_protected has been disabled by trusted-params plugin, use attr_accessible"
      end
    end
  end
end

# TODO for some reason this doesn't work for overriding methods
# ActiveRecord::Base.class_eval do
#   include TrustedParams::ActiveRecordAdditions
# end
