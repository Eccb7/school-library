require_relative '../base_decorator'

RSpec.describe BaseDecorator do
  let(:nameable) { double('Nameable', correct_name: 'Original Name') }
  let(:decorator) { BaseDecorator.new(nameable) }

  describe '#initialize' do
    it 'creates a BaseDecorator instance with a nameable object' do
      expect(decorator.nameable).to eq(nameable)
    end
  end

  describe '#correct_name' do
    it 'delegates the correct_name method to the nameable object' do
      expect(decorator.correct_name).to eq('Original Name')
    end
  end
end
