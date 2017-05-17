require 'rspec'
require_relative 'policy_example'

describe Policy do
  let(:rule) { Rule.new('first', 'be good to your parents') }
  let(:instance) { described_class.new('trumps bad healthcare') }

  describe '#<<' do
    it 'should add a rule' do
      instance << rule

      expect(instance['first']).to eq([rule])
    end
  end

  describe '#apply' do
    it 'should add an account value to each rule' do
      rule2 = Rule.new('first', 'be nice')
      rule3 = Rule.new('second', 'cheese')

      instance << rule
      instance << rule2
      instance << rule3

      instance.apply('this is the value')

      rule1 = instance['first'][0]
      rule2 = instance['first'][1]
      rule3 = instance['second'][0]

      expect(rule1.account_string).to eq('this is the value')
      expect(rule2.account_string).to eq('this is the value')
      expect(rule3.account_string).to eq('this is the value')
    end
  end
end


describe Rule do
  let(:instance) { described_class.new('first', 'be good to your parents') }

  describe '#apply' do
    it 'add values to the account_string' do
      instance.apply('Bacon burgers are good. ')
      instance.apply('Yes they are!')

      expect(instance.to_s).to eq('Bacon burgers are good. Yes they are!')
    end
  end
end
