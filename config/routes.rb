Rails.application.routes.draw do
  get 'visited_domains', to: 'domains#index'
  post 'visited_links', to: 'links#create'
end
