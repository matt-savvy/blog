defmodule Blog.HTMLConverter do
  def convert(_filepath, body, _atrs, _opts) do
    MDEx.to_html(body, features: [syntax_highlight_theme: "nightfox"])
  end
end
