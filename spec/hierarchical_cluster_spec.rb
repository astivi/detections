require 'hierarchical_cluster'
require 'track_detection'

RSpec.describe HierarchicalCluster, '#clusterize' do
  context 'given two different audio sources' do
    it 'segregates into different genres' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(2, 2)]
      cluster = HierarchicalCluster.new(detections, 0)
      expect(cluster.clusterize.size).to eq(2)
    end
  end

  context 'given the same audio source' do
    it 'aggregates into the same genre' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(1, 2)]
      cluster = HierarchicalCluster.new(detections, 0)
      expect(cluster.clusterize.size).to eq(1)
    end
  end

  context 'given the same track' do
    it 'aggregates into the same genre' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(2, 1)]
      cluster = HierarchicalCluster.new(detections, 0)
      expect(cluster.clusterize.size).to eq(1)
    end
  end

  context 'given four different detections with shared attributes' do
    it 'aggregates into the same genre' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(1, 2), TrackDetection.new(2, 1), TrackDetection.new(2, 2)]
      cluster = HierarchicalCluster.new(detections, 0)
      expect(cluster.clusterize.size).to eq(1)
    end
  end

  context 'given four different detections with mixed attributes' do
    it 'aggregates into two genres' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(1, 2), TrackDetection.new(3, 4), TrackDetection.new(4, 4)]
      cluster = HierarchicalCluster.new(detections, 0)
      expect(cluster.clusterize.size).to eq(2)
    end
  end

  context 'given two clusters with little intersection and a high threshold' do
    it 'segregates into two genres' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(1, 2), TrackDetection.new(1, 3), TrackDetection.new(2, 4), TrackDetection.new(2, 5), TrackDetection.new(2, 6), TrackDetection.new(1, 6)]
      cluster = HierarchicalCluster.new(detections, 0.66)
      expect(cluster.clusterize.size).to eq(2)
    end
  end

  context 'given two clusters with little intersection and a low threshold' do
    it 'aggregate into one genre' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(1, 2), TrackDetection.new(1, 3), TrackDetection.new(2, 4), TrackDetection.new(2, 5), TrackDetection.new(2, 6), TrackDetection.new(1, 6)]
      cluster = HierarchicalCluster.new(detections, 0.33)
      expect(cluster.clusterize.size).to eq(1)
    end
  end

  context 'matrix' do
    it 'stuff' do
      matrix = Array.new(2) {Array.new(2) {1}}
      print_likeness_matrix matrix
      matrix[1].delete_at(1)
      matrix[1].delete_at(0)
      matrix[0].delete_at(1)
      matrix[0].delete_at(0)
      matrix.delete_at(1)
      matrix.delete_at(0)
      matrix << [1.0]
      print_likeness_matrix matrix
      puts matrix
    end
  end
end

def print_likeness_matrix(matrix)
  puts '__________________'
  (0..matrix.size-1).each do |i|
    print '['
    (0..matrix[i].size-1).each do |j|
      print "#{matrix[i][j]},"
    end
    puts ']'
  end
end
