require_relative '../person'

RSpec.describe Person do
  let(:person) { Person.new(20, name: 'Alice', parent_permission: true) }

  describe '#can_use_services?' do
    it 'returns true when the person is of age' do
      expect(person.can_use_services?).to be true
    end

    it 'returns true when the person is under age but has parent permission' do
      underage_person = Person.new(16, name: 'Bob', parent_permission: true)
      expect(underage_person.can_use_services?).to be true
    end

    it 'returns false when the person is under age and lacks parent permission' do
      underage_person = Person.new(16, name: 'Charlie', parent_permission: false)
      expect(underage_person.can_use_services?).to be false
    end
  end
end
