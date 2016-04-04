defmodule Lucas do
  use Application
  # Import helpers for defining supervisors
  import Supervisor.Spec

  def start(_type, _args) do
    IO.puts "starting"
    # This time, we don't pass any argument because
    # the argument will be given when we start the child
    children = [
      worker(Lucas.BotPoller, [%{timeout: 1, update_id: 0}], restart: :transient)
    ]
    # Start the supervisor with our one child
    {:ok, sup_pid} = Supervisor.start_link(children, strategy: :simple_one_for_one)
    {:ok, pid} = Supervisor.start_child(sup_pid, [])
  end
end
