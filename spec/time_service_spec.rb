require 'spec_helper'

describe TimeService do
  let(:time_service) { Class.new { include TimeService } }

  describe '#offset_time' do
    let(:offset) { '-8:00' }
    let(:time_string) { '15 Dec 2016 14:00 +8' }
    let(:date_time) { DateTime.parse(time_string) }
    let(:offsetted_time_string) { '14 Dec 2016 22:00 -8' }
    let(:offsetted_time) { DateTime.parse(offsetted_time_string) }

    subject { time_service.new.offset_date_time(date_time, offset) }

    it 'should convert input time to specified timezone time' do
      expect(subject).to eq offsetted_time
    end
  end

  describe '#datetime_to_utc' do
    let(:time_string) { '16 Dec 2016 00:00 -8' }
    let(:date_time) { DateTime.parse(time_string) }
    let(:utc_time) { DateTime.parse('16 Dece 2016 8:00') }

    subject { time_service.new.datetime_to_utc(date_time) }

    it 'should convert input time to utc time' do
      expect(subject).to eq utc_time
    end
  end
end