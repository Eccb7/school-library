require_relative 'BaseDecorator'

class CapitalizeDecorator < BaseDecorator
  def correct_name
    super.capitalize
  end
end
