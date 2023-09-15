require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(id, classroom, name = 'Unknown', age = 0)
    super(id, name, age)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
