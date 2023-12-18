defmodule Blog.Site do
  use Phoenix.Component
  import Phoenix.HTML
  alias Phoenix.Template

  embed_templates("templates/*")

  @output_dir "./output"

  def build do
    File.mkdir_p!(@output_dir)

    posts = Blog.all_posts()
    render_file("index.html", "index", %{posts: posts})

    for post <- posts do
      dir = Path.dirname(post.path)
      File.mkdir_p!(Path.join([@output_dir, dir]))
      render_file(post.path, "post", %{post: post})
    end

    :ok
  end

  def render_file(path, template, assign) do
    safe = Template.render_to_iodata(__MODULE__, template, "html", assign)
    output = Path.join([@output_dir, path])

    File.write!(output, safe)
  end
end
