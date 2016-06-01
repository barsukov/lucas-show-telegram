defmodule Lucas.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    IO.puts "starting"
    # This time, we don't pass any argument because
    # the argument will be given when we start the child
    children = [
      worker(Lucas.BotPoller, [%{timeout: 1, update_id: 0}], restart: :transient)
    ]
    supervise(children, strategy: :one_for_one)
  end
end