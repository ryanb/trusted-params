module TrustedParams
  module ActiveRecordAdditions
    def self.included(base)
      base.extend(ClassMethods)
      base.alias_method_chain :remove_attributes_protected_from_mass_assignment, :trusted_params
    end
    
    def remove_attributes_protected_from_mass_assignment_with_trusted_params(attributes)
      unless self.class.accessible_attributes && self.class.accessible_attributes.include?("all")
        attributes.each do |key, value|
          unless (self.class.accessible_attributes && self.class.accessible_attributes.include?(key.to_s)) || attributes.trusted?(key)
            raise ActiveRecord::UnavailableAttributeAssignmentError, "attribute \"#{key}\" is protected from mass assignment, use attr_accessible"
          end
        end
      end
      attributes
    end
    
    module ClassMethods
      def self.extended(base)
        base.metaclass.alias_method_chain :attr_protected, :disabled
      end
      
      def attr_protected_with_disabled(*args)
        raise "attr_protected has been disabled by trusted-params plugin, use attr_accessible"
      end
    end
  end
end

module ActiveRecord
  Base.class_eval do
    include TrustedParams::ActiveRecordAdditions
  end
  
  class UnavailableAttributeAssignmentError < ActiveRecordError
  end
end
