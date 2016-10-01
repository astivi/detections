require_relative 'track_classification'

class BySourceFileWriter

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

  private

  def format_classification(track_classification)
    "#{track_classification.audio_source_id} | genre#{track_classification.genre_id}"
  end
end