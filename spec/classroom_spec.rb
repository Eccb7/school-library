require_relative '../classroom'

RSpec.describe Classroom do
  let(:classroom) { Classroom.new('Class A') }
  let(:student) { double('Student') }

  describe '#initialize' do
    it 'creates a Classroom instance with the given label' do
      expect(classroom.label).to eq('Class A')
    end

    it 'initializes students as an empty array' do
      expect(classroom.students).to be_empty
    end
  end

end
