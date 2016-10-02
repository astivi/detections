require_relative 'io/file_reader'
require_relative 'io/by_track_file_writer'
require_relative 'io/by_source_file_writer'
require_relative 'analysis/cluster_classificator'
require_relative 'analysis/hierarchical_cluster'

class Detections

  def detect(input_file)
    file_reader = FileReader.new(input_file)
    detections = file_reader.read_detections
    clusterizer = HierarchicalCluster.new(detections, 0.5)
    classificator = ClusterClassificator.new(clusterizer.clusterize)
    classifications = classificator.classify
    basename = File.basename(input_file.path, '.csv')
    by_track_output_file = File.open(File.expand_path("../../output/#{basename}.by_track", __FILE__), File::CREAT|File::TRUNC|File::RDWR)
    by_track_file_writer = ByTrackFileWriter.new(by_track_output_file)
    by_track_file_writer.write_genres(classifications)
    by_source_output_file = File.open(File.expand_path("../../output/#{basename}.by_source", __FILE__), File::CREAT|File::TRUNC|File::RDWR)
    by_source_file_writer = BySourceFileWriter.new(by_source_output_file)
    by_source_file_writer.write_genres(classifications)
  end

  def run
    if (ARGV.nil? or ARGV.size != 1)
      puts 'Usage: ruby detections.rb <file>'
      return 1
    end
    detect(File.open(ARGV[0]))
  rescue
    puts 'Input file could not be opened.'
  end
end

Detections.new.run