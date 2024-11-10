defmodule Blog.Site do
  import Phoenix.HTML, only: [raw: 1]
  import Phoenix.Template, only: [embed_templates: 1]

  alias Phoenix.Template

  alias Blog.Post

  embed_templates("templates/*")

  @assets_dir "./assets"
  @output_dir "./output"

  def build do
    File.mkdir_p!(@output_dir)
    copy_assets()

    render_file("about.html", "about")

    posts = Blog.all_posts()
    render_file("index.html", "index", %{posts: posts})

    render_xml(%{posts: posts})

    for post <- posts do
      dir = Path.dirname(post.path)
      File.mkdir_p!(Path.join([@output_dir, dir]))
      render_file(post.path, "post", %{post: post})
    end

    :ok
  end

  def render_file(path, template, assigns \\ %{}) do
    assigns = Map.merge(assigns, %{layout: {__MODULE__, "layout"}})
    safe = Template.render_to_iodata(__MODULE__, template, "html", assigns)
    output = Path.join([@output_dir, path])

    File.write!(output, safe)
  end

  def render_xml(assigns \\ %{}) do
    safe = Template.render_to_iodata(__MODULE__, "rss", "", assigns)
    output = Path.join([@output_dir, "rss.xml"])
    File.write!(output, safe)
  end

  def copy_assets do
    File.cp_r!(@assets_dir, Path.join([@output_dir, "assets"]))
  end

  def page_title(%{post: %Post{title: title}}), do: title
  def page_title(_assigns), do: "blog.1-800-rad-dude.com"

  defp rss_date(%DateTime{} = dt) do
    day_of_week = dt |> Date.day_of_week() |> day_str()
    %{day: day, month: month, year: year, hour: hour, minute: minute} = dt
    "#{day_of_week}, #{pad(day)} #{month_str(month)} #{year} #{pad(hour)}:#{pad(minute)} GMT"
  end

  defp rss_date(%Date{} = date) do
    date
    |> DateTime.new!(Time.new!(0, 0, 0))
    |> rss_date()
  end

  defp day_str(1), do: "Mon"
  defp day_str(2), do: "Tue"
  defp day_str(3), do: "Wed"
  defp day_str(4), do: "Thu"
  defp day_str(5), do: "Fri"
  defp day_str(6), do: "Sat"
  defp day_str(7), do: "Sun"

  defp month_str(1), do: "Jan"
  defp month_str(2), do: "Feb"
  defp month_str(3), do: "Mar"
  defp month_str(4), do: "Apr"
  defp month_str(5), do: "May"
  defp month_str(6), do: "Jun"
  defp month_str(7), do: "Jul"
  defp month_str(8), do: "Aug"
  defp month_str(9), do: "Sep"
  defp month_str(10), do: "Oct"
  defp month_str(11), do: "Nov"
  defp month_str(12), do: "Dec"

  defp pad(n) do
    n
    |> to_string()
    |> String.pad_leading(2, "0")
  end
end
