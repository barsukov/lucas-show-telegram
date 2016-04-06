defmodule Lucas.BotReplyHandler do

  def reply(%{"message" => %{"text" => text, "chat" => %{"id" => id}}}) do
    cond do
     text =~ ~r[/cat] ->
        Lucas.Bot.exec_cmd("sendMessage", %{chat_id: id, text: "Meow!"})
     text =~ ~r[/gelezka] ->
       Lucas.Bot.exec_cmd("sendMessage", %{chat_id: id, text: "Никита три мохито!"})
     text =~ ~r[/rank] ->
       rank = Lucas.RankCommand.get_rank
       Lucas.Bot.exec_cmd("sendMessage", %{chat_id: id, parse_mode: "Markdown", text: "```" <> rank <> "```"})
     true ->
       IO.puts "Not matched"
    end
  end
end
