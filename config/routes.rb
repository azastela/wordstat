Rails.application.routes.draw do
  post :word_counter, to: 'stats#word_counter'
  get :word_statistics, to: 'stats#word_statistics'
end
