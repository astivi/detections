#http://www.cs.utah.edu/~piyush/teaching/4-10-print.pdf
class HierarchicalCluster
  def initialize(detections, threshold)
    @detections = detections.map do |detection|
      Set.new [detection]
    end
    @threshold = threshold
  end

  def clusterize
    i, j = find_max_likeness
    until i.nil? && j.nil?
      merge_clusters(@detections[i], @detections[j])
      i, j = find_max_likeness
    end
    @detections
  end

  private

  def merge_clusters(one, other)
    @detections.delete(one)
    @detections.delete(other)
    @detections << one.merge(other)
  end

  def find_max_likeness
    max_i = max_j = nil
    max_likeness = @threshold
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
    alike = Array.new(cluster1.size + cluster2.size, 0)
    cluster1.each_with_index do |c1, i|
      cluster2.each_with_index do |c2, j|
        if c1.audio_source_id == c2.audio_source_id or c1.track_id == c2.track_id
          alike[i] = 1
          alike[alike.size - j] = 1
        end
      end
    end
    (1.0 * alike.count(1)) / (cluster1.size + cluster2.size)
  end
end