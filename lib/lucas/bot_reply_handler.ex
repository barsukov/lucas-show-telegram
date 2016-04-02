defmodule Lucas.BotReplyHandler do
  def reply(%{"message" => %{"text" => "/cat", "chat" => %{"id" => id}}}) do
    Lucas.Bot.exec_cmd("sendMessage", %{chat_id: id, text: "Cat!"})
  end

  def reply(_) do
    IO.puts "Not matched"
  end
end
