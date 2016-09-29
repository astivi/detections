require_relative 'file_reader'

class Detections

  def detect
    file = File.open('../fixtures/detections-first-1000.csv')
    file_reader = FileReader.new(file)
    file_reader.read_detections.map do |a|
      puts "[track_id: #{a.track_id}, audio_source_id: #{a.audio_source_id}]"
    end
  end
end

Detections.new.detect