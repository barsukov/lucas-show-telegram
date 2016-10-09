defmodule Lucas.Bot.TaskSupervisor do
  import Supervisor.Spec

  # A simple module attribute that stores the supervisor name
  @name Lucas.Bot.TaskSupervisor

  def init(:ok) do
    children = [
      worker(Task.Supervisor, [[name: Lucas.Bot]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
