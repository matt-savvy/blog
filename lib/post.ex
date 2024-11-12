defmodule Blog.Post do
  @enforce_keys [
    :id,
    :author,
    :title,
    :body,
    :description,
    :tags,
    :date,
    :datetime,
    :path
  ]
  defstruct [
    :id,
    :author,
    :title,
    :body,
    :description,
    :tags,
    :date,
    :datetime,
    :path
  ]

  def build(filename, attrs, body) do
    {path, date, id} = parse_filename(filename)

    dt = DateTime.new!(date, ~T[00:00:00Z])

    attrs
    |> Map.merge(%{id: id, date: date, datetime: dt, body: body, path: path})
    |> then(&struct!(__MODULE__, &1))
  end

  defp parse_filename(filename) do
    path = Path.rootname(filename)

    [year, month_day_id] = path |> Path.split() |> Enum.take(-2)
    [month, day, id] = String.split(month_day_id, "-", parts: 3)
    date = Date.from_iso8601!("#{year}-#{month}-#{day}")

    path = path <> ".html"

    {path, date, id}
  end
end
