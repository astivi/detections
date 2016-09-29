require_relative 'file_reader'
require_relative 'hierarchical_cluster'

class Detections

  def detect
    file = File.open('../fixtures/detections-first-1000.csv')
    file_reader = FileReader.new(file)
    detections = file_reader.read_detections
    puts 'File read!'
    clusterizer = HierarchicalCluster.new(detections, 0.5)
    clusterizer.clusterize.each do |a|
      puts a.size
    end
  end
end

Detections.new.detect