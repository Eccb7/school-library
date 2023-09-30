require_relative '../book'
require_relative '../person'

RSpec.describe Book do
  let(:book) { Book.new('Title', 'Author') }
  let(:person) { Person.new(18, 'Alice') }

  describe '#initialize' do
    it 'creates a Book instance with the given title and author' do
      expect(book.title).to eq('Title')
      expect(book.author).to eq('Author')
    end

    it 'initializes rentals as an empty array' do
      expect(book.rentals).to be_empty
    end
  end

end
