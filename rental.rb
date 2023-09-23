class Rental
  attr_accessor :date
  attr_reader :book, :person

  def initialize(book, person, date)
    @book = book
    @person = person
    @date = date
    @book.rentals << self if @book.respond_to?(:rentals) && @person.respond_to?(:rentals)
  end
end
