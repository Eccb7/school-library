require_relative '../student'

RSpec.describe Student do
  let(:student) { Student.new(18, 'Class A', 'Eve') }

  describe '#initialize' do
    it 'creates a Student instance with the given age, classroom, name, and parent_permission' do
      expect(student.age).to eq(18)
      expect(student.name).to eq('Eve')
    end

    it 'initializes rentals as an empty array' do
      expect(student.rentals).to be_empty
    end
  end

  describe '#play_hooky' do
    it 'returns a string' do
      expect(student.play_hooky).to be_a(String)
    end

    it 'returns the string "¯\(ツ)/¯"' do
      expect(student.play_hooky).to eq('¯\(ツ)/¯')
    end
  end
end
