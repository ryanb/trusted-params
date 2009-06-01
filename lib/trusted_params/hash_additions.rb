module TrustedParams
  module HashAdditions
    def trust(*attribute_names)
      if attribute_names.empty?
        @trusted_attributes = :all
      else
        @trusted_attributes = attribute_names.map(&:to_sym)
        attribute_names.each do |attribute_name|
          self[attribute_name].trust if self[attribute_name].kind_of? Hash
        end
      end
      self
    end
    
    def trusted?(attribute_name)
      if defined?(@trusted_attributes)
        @trusted_attributes == :all || @trusted_attributes.include?(attribute_name.to_sym)
      end
    end
  end
end

# I would prefer not setting this in all hashes, but it is the easiest solution at the moment.
class Hash
  include TrustedParams::HashAdditions
end
