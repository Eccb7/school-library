require_relative 'person'

class Teacher < Person
  attr_reader :specialization

  def initialize(id, specialization, name = 'Unknown', age = 0)
    super(id, name, age)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
