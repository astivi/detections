require 'model/track_classification'
require_relative 'file_writer'

class ByTrackFileWriter < FileWriter

  private

  def header
    'track_id | genre'
  end

  def comparator_attr(element)
    element.track_id
  end

  def format_classification(track_classification)
    "#{track_classification.track_id} | genre#{track_classification.genre_id}"
  end
end