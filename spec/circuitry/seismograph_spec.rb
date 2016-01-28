require 'spec_helper'

RSpec.describe Circuitry do
  subject { described_class.config }

  it 'incldues the publisher middleware' do
    expect(subject.publisher_middleware).to be_exists(Circuitry::Middleware::Seismograph)
  end

  it 'includes the subscriber middleware' do
    expect(subject.subscriber_middleware).to be_exists(Circuitry::Middleware::Seismograph)
  end
end
