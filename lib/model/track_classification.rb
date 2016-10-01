require_relative 'track_detection'

class TrackClassification < TrackDetection
  def initialize(audio_source_id, track_id, genre_id)
    super(audio_source_id, track_id)
    @genre_id = genre_id
  end
  attr_accessor :genre_id

  def ==(other)
    return false unless other.instance_of? TrackClassification
    @audio_source_id == other.audio_source_id && @track_id == other.track_id && @genre_id == other.genre_id
  end
end