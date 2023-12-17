defmodule Blog.Site do
  use Phoenix.Component
  import Phoenix.HTML
  alias Phoenix.Template

  @output_dir "./output"
  File.mkdir_p!(@output_dir)

  def build do
    posts = Blog.all_posts()
    render_file("index.html", "index", %{posts: posts})

    for post <- posts do
      dir = Path.dirname(post.path)

      if dir != "." do
        File.mkdir_p!(Path.join([@output_dir, dir]))
      end

      render_file(post.path, "post", %{post: post})
    end

    :ok
  end

  def render_file(path, template, assign) do
    safe = Template.render_to_iodata(__MODULE__, template, "html", assign)
    output = Path.join([@output_dir, path])

    File.write!(output, safe)
  end

  def post(assigns) do
    ~H"""
    <.layout>
      <%= raw @post.body %>
    </.layout>
    """
  end

  def index(assigns) do
    ~H"""
    <.layout>
      <h1>Blog</h1>
      <h2>Posts</h2>
      <ul>
        <li :for={post <- @posts}>
          <a href={post.path}> <%= post.title %> </a>
        </li>
      </ul>
    </.layout>
    """
  end

  def layout(assigns) do
    ~H"""
    <html>
      <body>
        <%= render_slot(@inner_block) %>
      </body>
    </html>
    """
  end
end
