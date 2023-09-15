require_relative 'person'

class Student < Person
  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, parent_permission, name)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end