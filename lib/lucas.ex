defmodule Lucas do
  use Application

  def start(_type, _args) do
    # Start the supervisor with our one child
    {:ok, pid} = Lucas.Supervisor.start_link
  end
end
