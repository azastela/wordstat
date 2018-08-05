require 'rails_helper'

RSpec.describe StatsService, type: :service do
  let!(:stat) { create(:stat) }
  let(:subject) { StatsService.new(input).perform }

  describe '#perform' do
    context 'input is a string' do
      let(:input) { 'foo bar test foo' }

      it 'updates word count in db' do
        subject
        stat.reload
        expect(stat.words[:foo]).to eq 2
      end
    end

    context 'input is a url' do
      let(:input) { 'http://www.test.com' }

      it 'updates word count in db' do
        expect(HTTParty).to receive(:get).and_return('foo bar test bar')
        subject
        stat.reload
        expect(stat.words[:bar]).to eq 2
      end
    end

    context 'input is a file' do
      let(:input) { fixture_file_upload('spec/fixtures/test.txt') }

      it 'updates word count in db' do
        subject
        stat.reload
        expect(stat.words[:lorem]).to eq 4
      end
    end
  end
end
