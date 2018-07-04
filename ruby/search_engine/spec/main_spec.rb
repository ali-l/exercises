require_relative '../main'

describe SearchEngine do
  subject { SearchEngine.new(seed_phrases) }

  let(:phrase1) { 'Wailord of a time' }
	let(:phrase2) { 'Lord of the Rings' }
	let(:phrase3) { 'Leather wings' }
  let(:seed_phrases) { [phrase1, phrase2, phrase3] }
  
  describe '#search' do	
    it 'should ignore case' do
      expect(subject.search('lord rings')).to eq([phrase2])
    end

    it 'should match partial words' do
      expect(subject.search('lord o a me')).to eq([phrase1])
      expect(subject.search('the win')).to eq([phrase3])
    end

    it 'should match words out of order' do
      expect(subject.search('of lord')).to eq([phrase1, phrase2])
      expect(subject.search('in lea')).to eq([phrase3])
    end
  end
end