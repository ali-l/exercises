class Index
  def initialize
    @string_map = {}
  end

  def add(text, word)
    (1..word.length).each do |length|
      word.chars.each_cons(length) do |strings|
        (@string_map[strings.join] ||= []) << text
        @string_map[strings.join].uniq!
      end
    end
  end

  def find(word)
    @string_map[word]
  end
end

class SearchEngine
  def initialize(documents)
    @index = Index.new
    @document_store = {}

    documents.each do |document|
      @document_store[document.name] = document

      document
          .name
          .downcase
          .split
          .map {|word| @index.add(document.name, word)}
    end
  end

  def search(phrase)
    results = phrase
                  .downcase
                  .split
                  .map {|word| @index.find(word)}

    results
        .reduce(results.first, :&)
        .map { |id| @document_store[id] }
  end
end