defmodule Whimsy.Tracker do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def state do
    Agent.get(__MODULE__, & &1)
  end

  def pee do
    Agent.update(__MODULE__, fn times ->
      [now(:pee) | times]
      |> broadcast_state()
    end)
  end

  def poo do
    Agent.update(__MODULE__, fn times ->
      [now(:poo) | times]
      |> broadcast_state()
    end)
  end

  defp now(type) do
    {type, Timex.now("America/New_York")}
  end

  defp broadcast_state(state) do
    WhimsyWeb.Endpoint.broadcast!("tracker", "state", %{state: state})
    state
  end
end
