require 'rails_helper'

RSpec.describe StatsController, type: :controller do
  let(:valid_params) { { input: 'foo' } }
  let!(:stat) { create(:stat, words: {test: 10, foo: 20, bar: 30}) }

  describe 'GET #word_statistics' do
    it 'returns a bad request response' do
      get :word_statistics, params: {}
      expect(response).to have_http_status(400)
    end

    it 'returns word statistic for passed word' do
      get :word_statistics, params: {input: 'foo'}
      expect(response).to have_http_status(200)
      expect(json_response[:count]).to eq 20
    end
  end

  describe 'GET #word_counter' do
    it 'returns a bad request response' do
      get :word_counter, params: { input: '' }
      expect(response).to have_http_status(400)
    end

    it 'returns word statistic for passed word' do
      expect(StatsJob).to receive(:perform_async).and_call_original
      get :word_counter, params: valid_params
      expect(response).to have_http_status(200)
      stat.reload
      expect(stat.words[:foo]).to eq 21
    end
  end
end
