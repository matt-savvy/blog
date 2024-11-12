defmodule Blog.RSSDateTime do
  @moduledoc """
  RSS uses RFC822 except with 4 digit years.
  """

  @doc """
  Converts Date / DateTime to RSS DateTime string.
  """
  def to_string(%DateTime{} = dt) do
    day_of_week = dt |> Date.day_of_week() |> day_str()
    %{day: day, month: month, year: year, hour: hour, minute: minute} = dt
    "#{day_of_week}, #{pad(day)} #{month_str(month)} #{year} #{pad(hour)}:#{pad(minute)} GMT"
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
    |> Kernel.to_string()
    |> String.pad_leading(2, "0")
  end
end
