require 'model/track_classification'

class FileWriter

  def initialize(classifications, file)
    @classifications = sort(classifications)
    @file = file
  end

  def write_genres
    @file.puts 'source_id | genre'
    @classifications.each do |classification|
      @file.puts(format_classification(classification))
    end
  end

  def format_classification
    raise 'Method not implemented, override in subclass'
  end

  def comparator_attr
    raise 'Method not implemented, override in subclass'
  end

  def sort(classifications)
    (classifications.uniq &method(:comparator_attr)).sort_by &method(:comparator_attr)
  end

end