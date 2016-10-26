require 'spec_helper'
require 'bifrost/message'
require 'bifrost/topic'
require 'bifrost/subscriber'

describe Bifrost::Message do
  subject(:message) { Bifrost::Message.new('subscriber_name', content: 'some data') }

  it { is_expected.to respond_to(:subject) }
  it { is_expected.to respond_to(:body) }
  it { is_expected.to respond_to(:post_to) }

  it 'should be postable to a valid topic' do
    topic = Bifrost::Topic.new('valid-topic')
    topic.save
    expect(message.post_to(topic)).to be_truthy
    topic.delete
  end

  it 'should not be postable to an invalid topic' do
    topic = Bifrost::Topic.new('invalid-topic')
    expect(message.post_to(topic)).to be_falsey
  end
end
