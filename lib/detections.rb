require_relative 'io/file_reader'
require_relative 'io/by_track_file_writer'
require_relative 'io/by_source_file_writer'
require_relative 'analysis/cluster_classificator'
require_relative 'analysis/hierarchical_cluster'

class Detections

  def run
    if (ARGV.nil? or ARGV.size != 2)
      puts 'Usage: ruby detections.rb <file> <clustering_threshold: [0.0-1.0]>'
      return 1
    end
    file_name = ARGV[0]
    puts "Reading file #{File.expand_path(file_name)}"
    detect(File.open(file_name), ARGV[1].to_f)
  rescue Exception => e
    puts e.message
  end

  private

  def detect(input_file, clustering_threshold)
    file_reader = FileReader.new(input_file)
    detections = file_reader.read_detections
    clusterizer = HierarchicalCluster.new(detections, clustering_threshold)
    classificator = ClusterClassificator.new(clusterizer.clusterize)
    classifications = classificator.classify
    basename = File.basename(input_file.path, '.csv')

    ByTrackFileWriter.new(open_file_for_writing(basename, 'by_track')).write_genres(classifications)
    BySourceFileWriter.new(open_file_for_writing(basename, 'by_source')).write_genres(classifications)
  end

  def open_file_for_writing(basename, type)
    output_file_name = File.expand_path("../../output/#{basename}.#{type}", __FILE__)
    puts "Saving output to #{output_file_name}"
    File.open(output_file_name, File::CREAT|File::TRUNC|File::RDWR)
  end

end

Detections.new.run