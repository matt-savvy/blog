defmodule Blog.HTMLConverter do
  def convert(_filepath, body, _atrs, _opts) do
    {:ok, html} =
      MDEx.to_html(body,
        features: [syntax_highlight_theme: "nightfox"],
        extension: [table: true, tagfilter: false, footnotes: true],
        render: [unsafe_: true]
      )

    html
  end
end
