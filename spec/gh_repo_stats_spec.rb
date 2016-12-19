require 'spec_helper'

describe GithubArchiveStats do
  let(:after_time_date) { "2012-11-01" }
  let(:after_time_hour) { "13" }
  let(:after_time) { DateTime.parse([after_time_date, "T", after_time_hour, ":00:00Z"].join("")) }
  let(:before_time) { DateTime.parse("2012-11-02T03:12:14-03:00") }
  let(:event_type) { "PushEvent" }
  let(:count) { 5 }
  let(:gh_arch) { GithubArchiveStats.new(after_time, before_time, event_type, count) }

  describe '#gh_file_name_for_specified_hour' do
    subject { gh_arch.gh_file_name_for_specified_hour(after_time) }

    let(:output) { [after_time_date, after_time_hour].join('-') }

    it 'should display as format YYYY-MM-DD-H' do
      expect(subject).to eq output
    end
  end

  describe '#parse_events' do
    subject {
      gh_arch.parse_events
      gh_arch.data
    }

    it 'should get specified number of repo' do
      expect(subject.count).to eq count
    end

    it 'should contain repo name' do
      expect(gh_arch.data.keys).to all(include("/"))
    end
  end
end