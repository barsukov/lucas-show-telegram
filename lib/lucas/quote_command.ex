defmodule Lucas.QuoteCommand do

  @quotes [ "Педроройсы", "Милнер тащун", "Сруболы", "Не маховик", "Надо уважать",
    "Никита три мохито", "Клайн-иисус", "Боруссия-мехельбах", "Сакочище" ]

  def get_random_quote() do
    Enum.random(@quotes)
  end

  def math_by_string(query) do
    Enum.filter(@quotes, fn(podcastQuote) -> String.starts_with?(podcastQuote, query) end)
  end

  def get_quote_by_query(query) do
    get_quotes = math_by_string(query)
    encoded_data = Enum.map get_quotes, fn (podcastQuote) ->
      %{
        type: "article",
        id: podcastQuote,
        title: podcastQuote,
        message_text: podcastQuote
      }
    end
    elem(Poison.encode(encoded_data), 1)
  end
end
