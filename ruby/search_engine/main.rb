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

  def find(text)
    results = text
                  .downcase
                  .split
                  .map {|word| find_word(word)}
                  .compact

    results.reduce(results.first, :&)
  end

  private

  def find_word(word)
    @string_map[word]
  end

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
  def initialize(documents = nil)
    @index = Index.new
    @document_store = {}

    documents&.each {|document| add(document)}
  end

  def add(document)
    @document_store[document.name] = document
    @index.add(document.name, document.name)
  end

  def search(text)
    @index.find(text)&.map {|id| @document_store[id]} || []
  end
end