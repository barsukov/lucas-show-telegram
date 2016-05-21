defmodule Lucas.JokeCommand do
  def get_joke_rank(text) do
    parts = String.split(text, "/joke")
    joke_point = String.strip(Enum.at(parts, 1)) |> Integer.parse
    if joke_point == :error do
      random = Enum.to_list 0..10
      joke_point = {Enum.random(random)}
    end
    joke_text = cond do
      elem(joke_point, 0) in 0..4 -> "#{elem(joke_point, 0)} Хондамира из 10"
      elem(joke_point, 0) in 5..10 -> "#{elem(joke_point, 0)} Хондамиров из 10"
      elem(joke_point, 0) > 10 -> "Шутка слишком мощная даже для Хондамира"
    end
    joke_text
  end
end
