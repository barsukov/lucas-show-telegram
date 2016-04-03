defmodule Lucas.BotPoller do
  use GenServer
  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, [name: :pooler_server])
  end

  def init(state) do
    IO.puts "Pooling server started"
    spawn fn ->
      handle_cast(:start_pool, state)
    end
    {:ok, state}
  end

  def handle_cast(:start_pool, state) do
    do_pool(state)
    {:noreply, state}
  end

  def process_messages_list({:ok, []}), do: -1

  def process_messages_list(results) do
    # for item <- results, do: item.message |> process_message
    %{"update_id" => update_id} = results
    update_id
  end

  def process_messages_list({:error, error}), do: Logger.log :error, error

  def do_pool(args) do
    try do
      update_id = Lucas.Bot.getUpdates(args) |> process_messages_list
      do_pool(%{timeout: args[:timeout], update_id: update_id + 1})
    rescue
      e in MatchError -> IO.inspect e
    end
  end
end
