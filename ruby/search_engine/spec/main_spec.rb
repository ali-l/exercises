require 'ostruct'
require_relative '../main'

describe SearchEngine do
  subject { SearchEngine.new(seed_documents) }

  let(:document1) { OpenStruct.new(name: 'Wailord of a time', foo: 'bar') }
	let(:document2) { OpenStruct.new(name: 'Lord of the Rings', abc: 'def') }
	let(:document3) { OpenStruct.new(name: 'Leather wings', bar: 'foo') }
  let(:seed_documents) { [document1, document2, document3] }
  
  describe '#search' do	
    it 'should ignore case' do
      expect(subject.search('lord rings')).to eq([document2])
    end

    it 'should match partial words' do
      expect(subject.search('lord o a me')).to eq([document1])
      expect(subject.search('the win')).to eq([document3])
    end

    it 'should match words out of order' do
      expect(subject.search('of lord')).to eq([document1, document2])
      expect(subject.search('in lea')).to eq([document3])
    end

    it 'should handle no documents being found' do
      expect(subject.search('abc')).to eq([])
    end
  end

  describe '#add' do
    it 'should add a document to the search engine' do
      document = OpenStruct.new(name: 'mario kart')
      subject.add(document)
      expect(subject.search('mario')).to eq([document])
    end
  end
end