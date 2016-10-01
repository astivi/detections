require 'io/by_source_file_writer'
require 'model/track_classification'

RSpec.describe BySourceFileWriter, '#write_genres' do
  context 'with a genre collection' do
    it 'writes each genre id and source_id into a file' do
      file = double('file')
      classifications = [TrackClassification.new(1,1,1), TrackClassification.new(3,1,1), TrackClassification.new(2,2,2)]
      file_writer = BySourceFileWriter.new(file)

      expect(file).to receive(:puts).with('source_id | genre').ordered
      expect(file).to receive(:puts).with('1 | genre1').ordered
      expect(file).to receive(:puts).with('2 | genre2').ordered
      expect(file).to receive(:puts).with('3 | genre1').ordered

      file_writer.write_genres(classifications)
    end
  end
end