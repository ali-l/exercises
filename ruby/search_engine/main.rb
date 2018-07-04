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
  def initialize(seed)
    @index = Index.new

    seed.each do |text|
      text
          .downcase
          .split
          .map {|word| @index.add(text, word)}
    end
  end

  def search(phrase)
    results = phrase
                  .downcase
                  .split
                  .map {|word| @index.find(word)}

    results.reduce(results.first, :&)
  end
end