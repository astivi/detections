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
    puts e.backtrace
  end

  private

  def detect(input_file, clustering_threshold)
    start = Time.now
    file_reader = FileReader.new(input_file)
    clusterizers = Array.new()
    clusterizer = HierarchicalCluster.new([], clustering_threshold)
    detections = file_reader.read_detections do |detection, index|
      if index%5000 == 0
        clusterizers << clusterizer
        clusterizer = HierarchicalCluster.new([], clustering_threshold)
      end
      clusterizer << detection
    end
    clusterizers << clusterizer
    puts ""
    while clusterizers.size > 1 do
      print "\rClusterizing... (#{clusterizers.size} clusterizers left.)"
      (0..(clusterizers.size/2).floor-1).each do |i|
        clusterizers[i].merge_clusterizer(clusterizers.delete_at(clusterizers.size-1))
      end
    end
    puts ""
    puts "File read"
    # clusterizer = HierarchicalCluster.new(detections, clustering_threshold)
    classificator = ClusterClassificator.new(clusterizers[0].clusterize)
    classifications = classificator.classify
    dend = Time.now
    puts "Time spend #{(dend - start) * 1000} millis"
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