defmodule Blog.Site do
  import Phoenix.HTML, only: [raw: 1]
  import Phoenix.Template, only: [embed_templates: 1]

  alias Phoenix.Template

  embed_templates("templates/*")

  @assets_dir "./assets"
  @output_dir "./output"

  def build do
    File.mkdir_p!(@output_dir)
    copy_assets()

    posts = Blog.all_posts()
    render_file("index.html", "index", %{posts: posts})

    for post <- posts do
      dir = Path.dirname(post.path)
      File.mkdir_p!(Path.join([@output_dir, dir]))
      render_file(post.path, "post", %{post: post})
    end

    :ok
  end

  def render_file(path, template, assigns) do
    assigns = Map.merge(assigns, %{layout: {__MODULE__, "layout"}})
    safe = Template.render_to_iodata(__MODULE__, template, "html", assigns)
    output = Path.join([@output_dir, path])

    File.write!(output, safe)
  end

  def copy_assets do
    File.cp_r!(@assets_dir, Path.join([@output_dir, "assets"]))
  end
end
