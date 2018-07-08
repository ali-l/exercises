class Index
  def initialize
    @terms = {}
  end

  def add(text, id)
    text
      .downcase
      .split
      .flat_map { |word| terms(word) }
      .uniq
      .tap { |terms| add_terms(terms, id) }
  end

  def find(text)
    text
      .downcase
      .split
      .map { |word| find_word(word) }
      .reduce(:&)
  end

  private

  def find_word(word)
    @terms[word] || []
  end

  def add_terms(terms, id)
    terms.each { |term| (@terms[term] ||= Set.new) << id }
  end

  def terms(word)
    chars = word.chars

    (1..word.length).flat_map { |term_length| terms_of_length(term_length, chars) }
  end

  def terms_of_length(length, chars)
    chars
      .each_cons(length)
      .map(&:join)
  end
end

class SearchEngine
  def initialize(seed_documents = [])
    @index = Index.new
    @documents = {}

    seed_documents.each { |document| add(document) }
  end

  def add(document)
    @documents[document.name] = document
    @index.add(document.name, document.name)
  end

  def search(text)
    @index
      .find(text)
      .map { |id| @documents[id] }
  end
end