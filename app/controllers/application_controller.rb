class ApplicationController < ActionController::Base
  def hello_world
    name = params['name'] || 'World'
    render 'application/hello_world', locals: { name: name }
  end
  def list_posts
    posts = connection.execute("SELECT * FROM posts")
    render 'application/list_posts', locals: { posts: posts }
  end
  def show_post
    post_id = params['id']

    post = connection.execute("SELECT * FROM posts WHERE posts.id = ? LIMIT 1", post_id).first

    render 'application/show_post', locals: { post: post }
  end
  def new_post
    render 'application/new_post'
  end
  def create_post
    title, body, author = params.values_at('title', 'body', 'author')

    post = BlogPost.new(
      'title' => title,
      'body' => body,
      'author' => author
    )
    post.save
    redirect_to '/posts'

  end
  def delete_post
    post_id = params['id']
    connection.execute("DELETE FROM posts WHERE posts.id = ?", post_id)

    redirect_to '/posts'

  end
  def edit_post
    post_id = params['id']
    post = connection.execute("SELECT * FROM posts WHERE posts.id = ? LIMIT 1", post_id).first

    render 'application/edit_post', locals: { post: post }
  end

  def update_post
    title, body, author, id = params.values_at('title', 'body', 'author', 'id')

    update_query = <<-SQL
      UPDATE posts
      SET title = ?,
          body = ?,
          author = ?
      WHERE posts.id = ?
    SQL
    connection.execute update_query,
      title,
      body,
      author,
      id

    redirect_to "/posts/#{id}"
  end

  private

  def connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end
end
