defmodule Whimsy.Tracker do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> {[], []} end, name: __MODULE__)
  end

  def state do
    Agent.get(__MODULE__, & &1)
  end

  def pee do
    Agent.update(__MODULE__, fn {pees, poos} ->
      {[fetch_time() | pees], poos}
      |> broadcast_state()
    end)
  end

  def poo do
    Agent.update(__MODULE__, fn {pees, poos} ->
      {pees, [fetch_time() | poos]}
      |> broadcast_state()
    end)
  end

  defp fetch_time do
    "now"
  end

  defp broadcast_state(state) do
    WhimsyWeb.Endpoint.broadcast!("tracker", "state", %{state: state})
    state
  end
end
