require 'analysis/cluster_classificator'
require 'model/track_detection'
require 'model/track_classification'

RSpec.describe ClusterClassificator, '#classify' do
  context 'given a list of clusters' do
    it 'create array of classifications' do
      clusters = [Set.new([TrackDetection.new(1, 1), TrackDetection.new(1, 2)]), Set.new([TrackDetection.new(3,3)])]
      classificator = ClusterClassificator.new(clusters)
      classifications = classificator.classify
      puts classifications.inspect
      expect(classifications.size).to eq(3)
      expect(classifications[1]).to be_a(TrackClassification)
      expect(classifications[1].audio_source_id).to eq(1)
      expect(classifications[1].track_id).to eq(2)
      expect(classifications[1].genre_id).to eq(1)
    end
  end

end
