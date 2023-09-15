class Person
  attr_reader :id, :name, :age

  def initialize(id, name = 'Unknown', age = 0)
    @id = id
    @name = name
    @age = age
  end

  attr_writer :name

  attr_writer :age

  private

  def of_age?
    @age >= 18
  end

  public

  def can_use_services?(parent_permission = true)
    of_age? || parent_permission
  end
end
