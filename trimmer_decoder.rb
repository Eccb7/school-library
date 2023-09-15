require_relative 'BaseDecorator'

class TrimmerDecorator < BaseDecorator
  def correct_name
    super[0, 10]
  end
end
