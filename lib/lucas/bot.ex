defmodule Lucas.Bot do
  use HTTPoison.Base
  require Logger

  def process_url(url) do
    "https://api.telegram.org/bot" <> token <> "/" <> url
  end

  defp token, do: System.get_env("TOT_TOKEN")

  def getUpdates(%{timeout: timeout, update_id: offset}) do
    Lucas.Bot.exec_cmd("getUpdates", %{timeout: timeout, offset: offset}) |> process_jobs
  end

  def exec_cmd(cmd, params) do
    case get(cmd, [], params: params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        unfold_resp(body)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        %{"ok" => true, "result" => "Not found"}
      {:error, err } ->
        %{"error" => true, "result" => err}
    end
  end

  def process_response_body(body) do
     body
     |> Poison.decode!
  end

  def unfold_resp(%{"ok" => true, "result" => result}) do
    result
  end

  def process_jobs([]), do: :noreply

  def process_jobs([job]) do
    process_job(job)
    job
  end

  def process_jobs([h|tail]) do
    process_job(h)
    process_jobs(tail)
  end

  def process_job(update) do
    try do
      spawn fn ->
        Lucas.BotReplyHandler.reply(update)
      end
    rescue
      e in MatchError -> Logger.log :warn, "[ERR] #{e}"
    end
  end
end
