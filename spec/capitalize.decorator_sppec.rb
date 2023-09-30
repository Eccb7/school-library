require_relative '../capitalize_decorator'

RSpec.describe CapitalizeDecorator do
  let(:nameable) { double('Nameable', correct_name: 'original name') }
  let(:decorator) { CapitalizeDecorator.new(nameable) }

  describe '#correct_name' do
    it 'capitalizes the nameable object\'s name' do
      expect(decorator.correct_name).to eq('Original name')
    end

    it 'delegates the correct_name method to the nameable object' do
      expect(nameable).to receive(:correct_name).and_return('original name')
      decorator.correct_name
    end
  end
end
