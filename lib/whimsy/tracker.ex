defmodule Whimsy.Tracker do
  use Agent
  use Timex

  def start_link(_opts) do
    Agent.start_link(fn -> {[], []} end, name: __MODULE__)
  end

  def state do
    Agent.get(__MODULE__, & &1)
  end

  def pee do
    Agent.update(__MODULE__, fn {pees, poos} ->
      {[now() | pees], poos}
      |> broadcast_state()
    end)
  end

  def poo do
    Agent.update(__MODULE__, fn {pees, poos} ->
      {pees, [now() | poos]}
      |> broadcast_state()
    end)
  end

  defp now do
    now = Timex.now("America/New_York") |> Timex.shift(days: -1, minutes: -45)

    approx =
      now
      |> Timex.format!("{relative}", :relative)

    exact =
      now
      |> Timex.format!("{h12}:{m}{am} {WDshort}")

    "#{exact} (#{approx})"
  end

  defp broadcast_state(state) do
    WhimsyWeb.Endpoint.broadcast!("tracker", "state", %{state: state})
    state
  end
end
