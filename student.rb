require_relative 'person'

class Student < Person
  def initialize(id, name = 'Unknown', age = 0, classroom)
    super(id, name, age)
    @classroom = classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
