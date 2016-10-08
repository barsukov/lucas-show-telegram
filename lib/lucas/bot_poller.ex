defmodule Lucas.BotPoller do
  use GenServer
  require Logger

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, [name: :poller_server])
  end

  def init(state) do
    Logger.info "Pooling server started"
    spawn fn ->
      handle_cast(:start_poll, state)
    end
    {:ok, state}
  end

  def handle_cast(:start_poll, state) do
    do_poll(state)
    {:noreply, state}
  end

  def do_poll(args) do
    update_id = Lucas.Bot.getUpdates(args)
    Logger.info "Current update_id: #{update_id}"
    do_poll(%{timeout: args[:timeout], update_id: update_id })
  end
end
