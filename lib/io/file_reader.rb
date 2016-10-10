require_relative '../model/track_detection'

class FileReader

  def initialize(file)
    @file = file
  end

  def read_detections
    results = []
    @file.each_with_index do |line, index|
      print "Reading file... (#{index} lines read so far)\r" if index%100 == 0
      next if index == 0
      detection = read_detection(line)
      results << detection
      yield Set.new([detection]), index if block_given?
    end
    results
  end

  private

  def read_detection(line)
    created_at, audio_source_id, track_id = line.split(',')
    TrackDetection.new(audio_source_id.to_i, track_id.to_i)
  end
end