require_relative '../main'

describe Spongemock do
  subject { Spongemock }

  describe '.transform' do
    it 'should change the input to alternate between upper and lowercase letters' do
      expect(subject.transform('hello')).to eq('HeLlO')
      expect(subject.transform('HELLO')).to eq('HeLlO')
    end

    it 'should ignore spaces' do
      expect(subject.transform('Hello world')).to eq('HeLlO wOrLd')
    end

    it 'should ignore punctuation' do
      expect(subject.transform("Hello, world. I'm SpongeBob.")).to eq("HeLlO, wOrLd. I'm SpOnGeBoB.")
    end
  end
end