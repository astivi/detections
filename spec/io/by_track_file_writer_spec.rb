require 'io/by_track_file_writer'
require 'model/track_classification'

RSpec.describe ByTrackFileWriter, '#write_genres' do
  context 'given a genre collection' do
    it 'writes each genre id and source_id into a file' do
      file = double('file')
      classifications = [TrackClassification.new(1,1,1), TrackClassification.new(3,1,1), TrackClassification.new(2,2,2)]
      file_writer = ByTrackFileWriter.new(classifications, file)

      expect(file).to receive(:puts).with('source_id | genre')
      expect(file).to receive(:puts).with('1 | genre1')
      expect(file).to receive(:puts).with('2 | genre2')

      file_writer.write_genres
    end
  end
end