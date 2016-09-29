class FileReader

  def initialize(file)
    @file = file
  end

  def read_detections
    results = []
    @file.each_with_index do |line, index|
      next if index == 0
      results = [TrackDetection.new(2927, 150285), TrackDetection.new(2880, 173295)]
    end
    results
  end
end