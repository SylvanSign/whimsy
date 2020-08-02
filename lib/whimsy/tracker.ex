defmodule Whimsy.Tracker do
  use Agent

  @list_length 20

  def start_link(_opts) do
    Agent.start_link(fn -> {0, []} end, name: __MODULE__)
  end

  def times do
    Agent.get(__MODULE__, &elem(&1, 1))
  end

  def pee do
    track(:pee)
  end

  def poo do
    track(:poo)
  end

  def meal do
    track(:meal)
  end

  def bath do
    track(:bath)
  end

  def emergency do
    track(:emergency)
  end

  def delete(id_to_delete) do
    Agent.update(__MODULE__, fn {id, times} ->
      {id, Enum.reject(times, &(elem(&1, 0) == id_to_delete))}
      |> broadcast_state()
    end)
  end

  defp track(action) do
    Agent.update(__MODULE__, fn {id, times} ->
      id = id + 1

      {id, [now(id, action) | times] |> Enum.take(@list_length)}
      |> broadcast_state()
    end)
  end

  defp now(id, type) do
    {id, type, Timex.now("America/New_York")}
  end

  defp broadcast_state({id, times}) do
    WhimsyWeb.Endpoint.broadcast!("tracker", "times", %{times: times})
    {id, times}
  end
end
