#http://www.cs.utah.edu/~piyush/teaching/4-10-print.pdf
class HierarchicalCluster
  def initialize(detections)
    @detections = detections.map do |detection|
      Set.new [detection]
    end
  end

  def clusterize
    i, j = find_max_likeness
    until i.nil? && j.nil?
      merge_clusters(@detections[i], @detections[j])
      i, j = find_max_likeness
    end
    @detections
  end

  def merge_clusters(one, other)
    @detections << [one.merge(other)]
    @detections.delete(one)
    @detections.delete(other)
  end

  def find_max_likeness
    max_i = max_j = nil
    max_likeness = 0
    (0..@detections.size-1).each do |i|
      (i+1..@detections.size-1).each do |j|
        likeness = calculate_likeness(@detections[i], @detections[j])
        return [i, j] if likeness == 1
        if likeness > max_likeness
          max_i = i
          max_j = j
        end
      end
    end
    [max_i, max_j]
  end

  def calculate_likeness(cluster1, cluster2)
    alike = 0
    cluster1.each do |i|
      cluster2.each do |j|
        if i.audio_source_id == j.audio_source_id or i.track_id == j.track_id
          alike = alike + 2
        end
      end
    end
    alike / (cluster1.size + cluster2.size)
  end
end