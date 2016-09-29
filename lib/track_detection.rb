class TrackDetection
  def initialize(audio_source_id, track_id)
    @audio_source_id = audio_source_id
    @track_id = track_id
  end
  attr_accessor :audio_source_id, :track_id
end