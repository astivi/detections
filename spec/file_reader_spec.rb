require 'file_reader'
require 'track_detection'

RSpec.describe FileReader, '#read_detections' do
  context 'given a valid file' do
    it 'reads its contents into Detections' do
      file = double('file')
      file_reader = FileReader.new(file)
      allow(file).to receive(:each_with_index)
                         .and_yield('created_at,audio_source_id,track_id', 0)
                         .and_yield('2016-07-05 00:00:01,2927,150285', 1)
                         .and_yield('2016-07-05 00:00:01,2880,173295', 2)
      detections = file_reader.read_detections
      expect(detections).to be_an(Array)
      expect(detections.size).to eq(2)
      expect(detections[0]).to be_a(TrackDetection)
      expect(detections[0].audio_source_id).to eq(2927)
      expect(detections[0].track_id).to eq(150285)
      expect(detections[1]).to be_a(TrackDetection)
      expect(detections[1].audio_source_id).to eq(2880)
      expect(detections[1].track_id).to eq(173295)
    end
  end

  context 'given an empty file' do
    it 'returns an empty array' do
      file = double('file')
      file_reader = FileReader.new(file)
      allow(file).to receive(:each_with_index)
      expect(file_reader.read_detections).to eq([])
    end
  end
end