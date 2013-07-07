require "useful_duration/version"
require 'active_support/duration'
require 'active_support/core_ext/time/calculations'
require 'active_support/core_ext/time/acts_like'
require 'active_support/core_ext/string/inflections.rb'

class Numeric

  def bravehearts
     ActiveSupport::Duration.new(self * 10620, [[:seconds, self * 10620]])
  end
  alias :braveheart :bravehearts

  def in_a_gadda_da_vidas
    ActiveSupport::Duration.new(self * 1023, [[:seconds, self * 1023]])
  end
  alias :in_a_gadda_da_vida :in_a_gadda_da_vidas

  def doctor_zhivagos
    ActiveSupport::Duration.new(self * 11820, [[:seconds, self * 11820]])
  end
  alias :doctor_zhivago :doctor_zhivagos

end

module UsefulDuration

  def useful_duration name, value
    # Send a `define_method` to Numeric class
    Numeric.send(:define_method, name) do
      ActiveSupport::Duration.new(self * value, [[:seconds, self * value]])
    end

    # Alias the "singular" method with it
    # For example, useful_duration :fortnights, 1209600
    #   will create #fortnights and #fortnight
    Numeric.send(:alias_method, singular_method(name), name)
  end

  private
  # Helper function to "singularlize" a method name (as a symbol)
  # Using ActiveSupport::Inflector::Inflections
  def singular_method name
    name.to_s.singularize.to_sym
  end

end
