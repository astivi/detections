require 'model/track_classification'

class FileWriter

  def initialize(classifications, file)
    @classifications = classifications
    @file = file
  end

  def write_genres
    @file.puts 'source_id | genre'
    @classifications.each do |classification|
      @file.puts(format_classification(classification))
    end
  end

end