defmodule Lucas.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    IO.puts "starting"

    children = [
      worker(Lucas.BotPoller, [%{timeout: 1, update_id: 0}], restart: :transient),
      supervisor(Task.Supervisor, [[name: Lucas.Bot.TaskSupervisor]])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
