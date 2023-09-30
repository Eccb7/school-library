require_relative '../teacher'

RSpec.describe Teacher do
  let(:teacher) { Teacher.new(35, 'Math', 'John Doe') }

  describe '#can_use_services?' do
    it 'returns true' do
      expect(teacher.can_use_services?).to be true
    end
  end

  describe 'inheritance' do
    it 'inherits from the Person class' do
      expect(Teacher.superclass).to eq(Person)
    end
  end

end
