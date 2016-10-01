class TrackDetection
  def initialize(audio_source_id, track_id)
    @audio_source_id = audio_source_id
    @track_id = track_id
  end
  attr_accessor :audio_source_id, :track_id

  def ==(other)
    return false unless other.instance_of? TrackDetection
    @audio_source_id == other.audio_source_id && @track_id == other.track_id
  end
end