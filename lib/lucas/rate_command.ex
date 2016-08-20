defmodule Lucas.RateCommand do

  defp get_points(text, type) do
    parts = String.split(text, type)
    joke_point = String.strip(Enum.at(parts, 1)) |> Integer.parse
    if joke_point == :error do
      random = Enum.to_list 0..10
      joke_point = {Enum.random(random)}
    end
    joke_point
  end

  def get_top_rank(text) do
    joke_point = get_points(text, "/top")
    joke_text = cond do
      elem(joke_point, 0) in 0..4 -> "#{elem(joke_point, 0)} Кексатопа из 10"
      elem(joke_point, 0) in 5..10 -> "#{elem(joke_point, 0)} Кексатопов из 10"
      elem(joke_point, 0) > 10 -> "Этот топчик слишком топ для кексотопа"
    end
    joke_text
  end

  def get_joke_rank(text) do
    joke_point = get_points(text, "/joke")
    joke_text = cond do
      elem(joke_point, 0) in 0..4 -> "#{elem(joke_point, 0)} Хондамира из 10"
      elem(joke_point, 0) in 5..10 -> "#{elem(joke_point, 0)} Хондамиров из 10"
      elem(joke_point, 0) > 10 -> "Шутка слишком мощная даже для Хондамира"
    end
    joke_text
  end
end
