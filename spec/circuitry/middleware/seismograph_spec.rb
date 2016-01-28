require 'spec_helper'

RSpec.describe Circuitry::Middleware::Seismograph do
  subject { described_class.new(options) }

  describe '#namespace' do
    describe 'when a namespace is supplied' do
      let(:options) { { namespace: 'namespace', stat: 'stat' } }
      its(:namespace) { is_expected.to eq 'namespace' }
    end

    describe 'when a namespace is not supplied' do
      let(:options) { { stat: 'stat' } }
      its(:namespace) { is_expected.to eq 'circuitry' }
    end
  end

  describe '#stat' do
    describe 'when a stat is supplied' do
      let(:options) { { stat: 'stat' } }
      its(:stat) { is_expected.to eq 'stat' }
    end

    describe 'when a namespace is not supplied' do
      let(:options) { {} }

      it 'raises an error' do
        expect { subject.stat }.to raise_error(KeyError)
      end
    end
  end

  describe '#call' do
    before do
      allow(Seismograph::Sensor).to receive(:new).and_return(sensor)
      allow(Seismograph::Log).to receive(:error)
      allow(sensor).to receive(:benchmark) { |*_args, &block| block.call }
    end

    let(:sensor) { double('Seismograph::Sensor') }
    let(:options) { { namespace: 'namespace', stat: 'stat' } }

    describe 'when processing succeeds' do
      def call!
        subject.call('mytopic', 'mymessage') { }
      end

      it 'benchmarks message processing' do
        call!
        expect(sensor).to have_received(:benchmark).with('stat', tags: %w[topic:mytopic])
      end

      it 'does not log an error event' do
        call!
        expect(Seismograph::Log).to_not have_received(:error)
      end
    end

    describe 'when processing raises an error' do
      def call!
        subject.call('mytopic', 'mymessage') { raise StandardError, 'error' }
      end

      it 'logs an error event' do
        call! rescue nil
        expect(Seismograph::Log).to have_received(:error).with('Circuitry message processing failed', description: 'error', tags: ['topic:mytopic'])
      end

      it 'raises the error' do
        expect { call! }.to raise_error(StandardError)
      end
    end
  end
end
