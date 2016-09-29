require 'file_reader'

RSpec.describe FileReader, '#read_detections' do
  context 'given a valid file' do
    it 'reads its contents into Detections' do
      file = double('file')
      file_reader = FileReader.new(file)
      allow(file).to receive(:each).and_return('created_at,audio_source_id,track_id', '2016-07-05 00:00:01,2927,150285', '2016-07-05 00:00:01,2880,173295')
      expect(file_reader.read_detections).to be_an(Array)
    end
  end
end