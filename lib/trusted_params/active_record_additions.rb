module TrustedParams
  module ActiveRecordAdditions
    def self.included(base)
      base.extend(ClassMethods)
      base.attr_accessible nil
    end
    
    def remove_attributes_protected_from_mass_assignment(attributes)
      unless self.class.accessible_attributes.include? "all"
        attributes.each do |key, value|
          unless self.class.accessible_attributes.include? key.to_s
            raise ActiveRecord::UnavailableAttributeAssignmentError, "attribute \"#{key}\" is protected from mass assignment"
          end
        end
      end
      attributes
    end
    
    module ClassMethods
      def attr_protected(*args)
        raise "attr_protected has been disabled by trusted-params plugin, use attr_accessible"
      end
    end
  end
end

module ActiveRecord
  # TODO for some reason this doesn't work for overriding methods
  # Base.class_eval do
  #   include TrustedParams::ActiveRecordAdditions
  # end
  
  class UnavailableAttributeAssignmentError < ActiveRecordError
  end
end
