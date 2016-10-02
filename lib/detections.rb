require_relative 'io/file_reader'
require_relative 'io/by_track_file_writer'
require_relative 'io/by_source_file_writer'
require_relative 'analysis/cluster_classificator'
require_relative 'analysis/hierarchical_cluster'

class Detections

  def detect
    input_file = File.open(File.expand_path('../../fixtures/detections-first-1000.csv', __FILE__))
    file_reader = FileReader.new(input_file)
    detections = file_reader.read_detections
    clusterizer = HierarchicalCluster.new(detections, 0.5)
    classificator = ClusterClassificator.new(clusterizer.clusterize)
    classifications = classificator.classify
    by_track_output_file = File.open(File.expand_path('../../output/detections-first-1000.by_track.csv', __FILE__), 'a')
    by_track_file_writer = ByTrackFileWriter.new(by_track_output_file)
    by_track_file_writer.write_genres(classifications)
    by_source_output_file = File.open(File.expand_path('../../output/detections-first-1000.by_source.csv', __FILE__), 'a')
    by_source_file_writer = BySourceFileWriter.new(by_source_output_file)
    by_source_file_writer.write_genres(classifications)
  end
end

Detections.new.detect