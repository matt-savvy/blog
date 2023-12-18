defmodule Blog do
  alias Blog.Post

  use NimblePublisher,
    build: Post,
    from: "./posts/**/*.md",
    as: :posts,
    html_converter: Blog.HTMLConverter,
    earmark_options: %Earmark.Options{smartypants: false}

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  def all_posts, do: @posts
end
