#References
#http://www.cs.utah.edu/~piyush/teaching/4-10-print.pdf
#http://home.deib.polimi.it/matteucc/Clustering/tutorial_html/hierarchical.html
require 'matrix'
require 'set'
class HierarchicalCluster
  def initialize(detections, threshold)
    @detections = detections.map do |detection|
      Set.new [detection]
    end
    @threshold = threshold
    @likeness_matrix = Array.new(@detections.size) { Array.new(@detections.size) { -1 } }
    build_likeness_matrix
  end

  def clusterize
    i, j = find_merge_candidate
    until i.nil? && j.nil?
      merge_clusters(i, j)
      i, j = find_merge_candidate
    end
    @detections
  end

  private

  def build_likeness_matrix
    (0..@likeness_matrix.size-1).each do |i|
      (0..@likeness_matrix.size-1).each do |j|
        @likeness_matrix[i][j] = calculate_likeness(@detections[i], @detections[j])
      end
    end
  end

  def merge_clusters(one, other)
    detection_one = @detections[one]
    detection_other = @detections[other]
    merged = detection_one.merge(detection_other)
    @detections.delete(detection_one)
    @detections.delete(detection_other)
    @detections << merged
    (0..@likeness_matrix.size-1).each do |i|
      @likeness_matrix[i].delete_at([one, other].max)
      @likeness_matrix[i].delete_at([one, other].min)
    end
    @likeness_matrix.delete_at([one, other].max)
    @likeness_matrix.delete_at([one, other].min)
    (0..@likeness_matrix.size-1).each do |i|
      new_likeness = calculate_likeness(merged, @detections[i])
      @likeness_matrix[i] << new_likeness
    end
    @likeness_matrix << Array.new(@detections.size) {|index| calculate_likeness(merged, @detections[index])}
  end

  def find_merge_candidate
    (0..@likeness_matrix.size-1).each do |i|
      (0..@likeness_matrix[i].size-1).each do |j|
        return [i, j] if i != j and @likeness_matrix[i][j] >= @threshold
      end
    end
    [nil, nil]
  end

  def calculate_likeness(cluster1, cluster2)
    alike = Array.new(cluster1.size + cluster2.size, 0)
    cluster1.each_with_index do |c1, i|
      cluster2.each_with_index do |c2, j|
        if c1.audio_source_id == c2.audio_source_id or c1.track_id == c2.track_id
          alike[i] = 1
          alike[(alike.size - 1) - j] = 1
        end
      end
    end
    (1.0 * alike.count(1)) / (cluster1.size + cluster2.size)
  end
end