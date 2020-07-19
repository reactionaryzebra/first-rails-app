Rails.application.routes.draw do
  get '/hello_world' => 'application#hello_world'
  get '/hello/:name' => 'application#hello_world'
  get '/posts/:id' => 'application#show_post'
  post '/posts/:id' => 'application#delete_post'
  get '/posts' => 'application#list_posts'
  get '/new' => 'application#new_post'
  post '/new' => 'application#create_post'
  get '/edit/:id' => 'application#edit_post'
end
