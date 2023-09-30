require_relative '../rental'
require_relative '../book'
require_relative '../person'

RSpec.describe Rental do
  let(:book) { Book.new('Title', 'Author') }
  let(:person) { Person.new(30, name: 'Bob') }
  let(:date) { '2023-09-23' }
  let(:rental) { Rental.new(book, person, date) }

  describe '#initialize' do
    it 'creates a Rental instance with the given book, person, and date' do
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
      expect(rental.date).to eq(date)
    end
  end
end
