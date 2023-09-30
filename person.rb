require_relative 'nameable'

class Person < Nameable
  attr_reader :id
  attr_accessor :age, :name

  def initialize(age, name: 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def to_json(*args)
    {
      id: @id,
      name: @name,
      age: @age,
      parent_permission: @parent_permission,
      rentals: @rentals.map(&:to_json)
    }.to_json(*args)
  end

  private

  def of_age?
    @age >= 18
  end

  public

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def rent_book(book, date)
    rental = Rental.new(book, self, date)
    @rentals << rental
    book.add_rental(rental)
  end
end
