require 'model/track_classification'
require_relative 'file_writer'

class BySourceFileWriter < FileWriter

  private

  def comparator_attr(element)
    element.audio_source_id
  end

  def format_classification(track_classification)
    "#{track_classification.audio_source_id} | genre#{track_classification.genre_id}"
  end
end