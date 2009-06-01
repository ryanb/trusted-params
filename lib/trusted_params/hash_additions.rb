module TrustedParams
  module HashAdditions
    def trust(*attribute_names)
      if attribute_names.empty?
        @trusted_attributes = :all
        each_key { |k| self[k].trust if self[k].kind_of? Hash }
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

# override "dup" method because it doesn't carry over trusted attributes
# I wish there was a better way to do this...
class HashWithIndifferentAccess
  def dup_with_trusted_attributes
    hash = dup_without_trusted_attributes
    hash.instance_variable_set("@trusted_attributes", @trusted_attributes) if defined?(@trusted_attributes)
    hash
  end
  alias_method_chain :dup, :trusted_attributes
end