require 'hierarchical_cluster'
require 'track_detection'

RSpec.describe HierarchicalCluster, '#clusterize' do
  context 'given two different audio sources' do
    it 'segregates into different genres' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(2, 2)]
      cluster = HierarchicalCluster.new(detections)
      expect(cluster.clusterize.size).to eq(2)
    end
  end

  context 'given the same audio source' do
    it 'aggregates into the same genre' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(1, 2)]
      cluster = HierarchicalCluster.new(detections)
      expect(cluster.clusterize.size).to eq(1)
    end
  end
end
