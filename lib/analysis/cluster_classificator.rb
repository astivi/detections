require_relative '../model/track_detection'
require_relative '../model/track_classification'

class ClusterClassificator

  def initialize(clusters)
    @clusters = clusters
  end

  def classify
    results = []
    @clusters.each_with_index do |cluster, index|
      cluster.each do |track_detection|
        results << TrackClassification.new(track_detection.audio_source_id, track_detection.track_id, index+1)
      end
    end
    results
  end

end