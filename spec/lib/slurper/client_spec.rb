require 'spec_helper'

describe Slurper::Client do
  subject { Slurper::Client }

  it 'uses the project id in the url' do
    expect(described_class::CREATE_STORY_URL).to eq "https://www.pivotaltracker.com/services/v5/projects/12345/stories"
  end

  describe '#create' do
    let(:story) { Slurper::Story.new }
    before { story.stub(:requested_by_id).and_return(11) }

    it 'posts the story to pivotal' do
      expect(Typhoeus).to receive(:post).with(
        Slurper::Client::CREATE_STORY_URL,
        body: story.to_json,
        headers: { "Content-Type" => "application/json", "X-TrackerToken" => Slurper::Config.token }
      )
      Slurper::Client.create(story)
    end
  end

  describe '#users' do
    it 'retrieves the users from pivotal' do
      expect(Typhoeus).to receive(:get).with(
        Slurper::Client::USERS_URL,
        headers: { "X-TrackerToken" => Slurper::Config.token }
      )
      Slurper::Client.users
    end
  end

end
