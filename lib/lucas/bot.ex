defmodule Lucas.Bot do
  use HTTPoison.Base
  require Logger

  def process_url(url) do
    "https://api.telegram.org/bot" <> token <> "/" <> url
  end

  defp token, do: System.get_env("TOT_TOKEN")

  def getUpdates(%{timeout: timeout, update_id: offset}) do
    exec_cmd("getUpdates", %{timeout: timeout, offset: offset})
    |> resolve_updates
  end

  def resolve_updates({
    offset,
    {
      :ok,
      %HTTPoison.Response{
        status_code: 200,
        body: %{"ok" => true, "result" => []}
      }
    }
  }) do
    offset
  end

  def resolve_updates({
    offset,
    {
      :ok,
      %HTTPoison.Response{
        status_code: 200,
        body: %{"ok" => true, "result" => result}
      }
    }
  }) do
    result
    |> process_messages
  end

  def resolve_updates({ offset, { :ok, %HTTPoison.Response { status_code: 404 } } } ) do
    offset
  end

  def resolve_updates({ offset, { :error, err }}) do
    Logger.error err
    offset
  end

  def exec_cmd(cmd, params=%{offset: offset}) do
    {offset, get(cmd, [], params: params)}
  end

  def exec_cmd(cmd, params) do
    get(cmd, [], params: params)
  end

  def process_response_body(body) do
     body
     |> Poison.decode!
  end

  def process_messages([message]=[%{"update_id"=>update_id}]) do
    process_message(message)
    #last message, so the offset is moving to +1
    update_id + 1
  end

  def process_messages([h|t]) do
    process_message(h)
    process_messages(t)
  end

  def process_message(message) do
    try do
      spawn fn ->
        Lucas.BotReplyHandler.reply(message)
      end
    rescue
      e in MatchError -> Logger.log :warn, "[ERR] #{e}"
    end
  end
end
