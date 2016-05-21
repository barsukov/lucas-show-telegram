defmodule Lucas.JokeCommand do
  def get_joke_rank(text) do
    parts = String.split(text, "/joke ")
    joke_point = Integer.parse Enum.at(parts, 1)

    joke_text = cond do
      joke_point == :error -> "Не нервируй меня малыш"
      elem(joke_point, 0) in 0..4 -> "#{elem(joke_point, 0)} Хондамира из 10"
      elem(joke_point, 0) in 5..10 -> "#{elem(joke_point, 0)} Хондамиров из 10"
      elem(joke_point, 0) > 10 -> "Шутка слишком мощная даже для Хондамира"
    end
    joke_text
  end
end
