defmodule Lucas.QuoteCommand do

  @quotes [ "Педроройсы", "Милнер тащун", "Сруболы", "Не маховик", "Надо уважать",
    "Никита три мохито", "Клайн-иисус", "Надо брать", "Боруссия-менхельбах",
    "Сакочище", "Дед Никита", "Йеп", "Ноуп" ]

  def get_random_quote() do
    Enum.random(@quotes)
  end

  def match_by_string(query) do
    downcasedQuery = String.downcase(query)
    Enum.filter(@quotes, fn(podcastQuote) ->
      String.starts_with?(String.downcase(podcastQuote), downcasedQuery)
    end)
  end

  def get_quote_by_query(query) do
    length = String.length(query)
    get_quotes = cond do
      length > 0 -> match_by_string(query)
      length == 0 -> @quotes
    end

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
