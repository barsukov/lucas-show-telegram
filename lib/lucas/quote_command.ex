defmodule Lucas.QuoteCommand do
  @quotes [ "Педроройсы", "Милнер тащун", "Сруболы", "Не маховик", "Надо уважать",
    "Никита три мохито", "Клайн-иисус", "Боруссия-мехельбах", "Сакочище" ]

  def get_random_quote() do
    Enum.random(@quotes)
  end
end
