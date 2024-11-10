defmodule Blog.RSSDateTimeTest do
  use ExUnit.Case

  alias Blog.RSSDateTime

  describe "to_string/1" do
    test "for DateTime" do
    dt = ~U[2024-08-09 09:01:10Z]

    assert "Fri, 09 Aug 2024 09:01 GMT" == RSSDateTime.to_string(dt)
    end

    test "for Date" do
      date = ~D[2024-08-09]

      assert "Fri, 09 Aug 2024 00:00 GMT" == RSSDateTime.to_string(date)
    end
  end
end
