class StatsService
  MEGABYTE = 1024 * 1024
  WORD_REGEXP = /[^[[:word:]]]+/
  IO_SEPARATOR = ' '

  attr_reader :input

  def initialize(input)
    @input = input
  end

  def perform
    if input.respond_to?(:path)
      File.open(input.path).each(IO_SEPARATOR, MEGABYTE) do |chunk|
        count_words(chunk)
      end
    else
      uri = URI.parse(input) rescue nil
      # expect that remote url response is plain/text
      if uri && %w(http https).include?(uri.scheme)
        response = HTTParty.get(uri)
        count_words(response)
      else
        count_words(input)
      end
    end

    stat.save!
  end

  private

  def count_words(text)
    stat_words = stat.words
    words = text.split(WORD_REGEXP).map(&:downcase)

    words.each do |word|
      count = stat_words[word]
      stat_words[word] = count ? count += 1 : 1
    end
  end

  def stat
    @stat ||= Stat.first
  end
end