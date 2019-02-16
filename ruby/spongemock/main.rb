class Spongemock
  class << self
    def transform(text)
      upper_case = false

      text.chars.map do |char|
        next char if char =~ /\W/

        (upper_case = !upper_case) ? char.upcase : char.downcase
      end.join
    end
  end
end

puts Spongemock.transform(ARGV[0])