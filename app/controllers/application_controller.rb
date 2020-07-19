class ApplicationController < ActionController::Base
  def hello_world
    name = params['name'] || 'World'
    render 'application/hello_world', locals: { name: name }
  end
  def list_posts
    connection = SQLite3::Database.new 'db/development.sqlite3'
    connection.results_as_hash = true

    posts = connection.execute("SELECT * FROM posts")
    render 'application/list_posts', locals: { posts: posts }
  end
  def show_post
    post_id = params['id']

    connection = SQLite3::Database.new 'db/development.sqlite3'
    connection.results_as_hash = true

    post = connection.execute("SELECT * FROM posts WHERE posts.id = ? LIMIT 1", post_id).first

    render plain: post['title']
  end
end
