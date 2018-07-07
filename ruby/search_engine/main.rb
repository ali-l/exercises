class Index
  def initialize
    @string_map = {}
  end

  def add(id, text)
    text
        .downcase
        .split
        .map {|word| add_word(id, word)}
  end

  def find(word)
    @string_map[word]
  end

  private

  def add_word(id, word)
    (1..word.length).each do |length|
      word.chars.each_cons(length) do |strings|
        (@string_map[strings.join] ||= []) << id

        @string_map[strings.join].uniq!
      end
    end
  end
end

class SearchEngine
  def initialize(documents)
    @index = Index.new
    @document_store = {}

    documents.each do |document|
      @document_store[document.name] = document
      @index.add(document.name, document.name)
    end
  end

  def search(phrase)
    results = phrase
                  .downcase
                  .split
                  .map {|word| @index.find(word)}

    results
        .reduce(results.first, :&)
        .map {|id| @document_store[id]}
  end
end