require_relative 'person'

class Student < Person
  attr_reader :rentals
  
  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name: name, parent_permission: parent_permission)
    @classroom = classroom
    @rentals = []
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def join_classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
