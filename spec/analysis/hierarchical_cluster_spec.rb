require 'analysis/hierarchical_cluster'
require 'model/track_detection'

RSpec.describe HierarchicalCluster, '#clusterize' do
  before do
    allow_any_instance_of(HierarchicalCluster).to receive(:print)
    allow_any_instance_of(HierarchicalCluster).to receive(:puts)
  end

  context 'given two different audio sources' do
    it 'segregates into different genres' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(2, 2)]
      cluster = HierarchicalCluster.new(detections, 0.1)
      expect(cluster.clusterize.size).to eq(2)
    end
  end

  context 'given the same audio source' do
    it 'aggregates into the same genre' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(1, 2)]
      cluster = HierarchicalCluster.new(detections, 0.1)
      expect(cluster.clusterize.size).to eq(1)
    end
  end

  context 'given the same track' do
    it 'aggregates into the same genre' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(2, 1)]
      cluster = HierarchicalCluster.new(detections, 0.1)
      expect(cluster.clusterize.size).to eq(1)
    end
  end

  context 'given four different detections with shared attributes' do
    it 'aggregates into the same genre' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(1, 2), TrackDetection.new(2, 1), TrackDetection.new(2, 2)]
      cluster = HierarchicalCluster.new(detections, 0.1)
      expect(cluster.clusterize.size).to eq(1)
    end
  end

  context 'given four different detections with mixed attributes' do
    it 'aggregates into two genres' do
      detections = [TrackDetection.new(1, 1), TrackDetection.new(1, 2), TrackDetection.new(3, 4), TrackDetection.new(4, 4)]
      cluster = HierarchicalCluster.new(detections, 0.1)
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

end
