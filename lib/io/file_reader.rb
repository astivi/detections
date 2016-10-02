require_relative '../model/track_detection'

class FileReader

  def initialize(file)
    @file = file
  end

  def read_detections
    results = []
    @file.each_with_index do |line, index|
      next if index == 0
      results << read_detection(line)
    end
    results
  end

  private

  def read_detection(line)
    created_at, audio_source_id, track_id = line.split(',')
    TrackDetection.new(audio_source_id.to_i, track_id.to_i)
  end
end