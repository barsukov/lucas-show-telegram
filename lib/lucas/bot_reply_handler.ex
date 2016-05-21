defmodule Lucas.BotReplyHandler do
  def reply(%{"inline_query" => %{"id" => id , "query" => query}}) do
    results = Lucas.QuoteCommand.get_quote_by_query(query)
    Lucas.Bot.exec_cmd("answerInlineQuery", %{inline_query_id: id, results: results})
  end

  def reply(%{"message" => %{"left_chat_participant" => member, "chat" => %{"id" => id}}}) do
    Lucas.Bot.exec_cmd("sendMessage", %{chat_id: id, text: "Скатертью дорога @#{member["username"]}" })
  end

  def reply(%{"message" => %{"new_chat_member" => member, "chat" => %{"id" => id}}}) do
    message_template = "Привет дорогой @#{member["username"]}, раскажи о себе! Тебе здесь всегда рады!"
    Lucas.Bot.exec_cmd("sendMessage", %{chat_id: id, text: message_template})
  end

  def reply(%{"message" => %{"text" => text, "chat" => %{"id" => id}}}) do
    cond do
     text =~ ~r[/cat] ->
        Lucas.Bot.exec_cmd("sendMessage", %{chat_id: id, text: "Meow!"})
     text =~ ~r[/joke] ->
       joke_text = Lucas.JokeCommand.get_joke_rank(text)
       Lucas.Bot.exec_cmd("sendMessage", %{chat_id: id, text: joke_text})
     text =~ ~r[/gelezka] ->
       random_quote = Lucas.QuoteCommand.get_random_quote
       Lucas.Bot.exec_cmd("sendMessage", %{chat_id: id, text: random_quote})
     text =~ ~r[/rank] ->
       rank = Lucas.RankCommand.get_rank
       Lucas.Bot.exec_cmd("sendMessage", %{chat_id: id, parse_mode: "Markdown", text: "```" <> rank <> "```"})
     true ->
       IO.puts "Not matched"
    end
  end
end
