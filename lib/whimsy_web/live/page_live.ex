defmodule WhimsyWeb.PageLive do
  use WhimsyWeb, :live_view
  alias Whimsy.Tracker

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      WhimsyWeb.Endpoint.subscribe("tracker")
    end

    {pees, poos} = Tracker.state()
    {:ok, assign(socket, pees: pees, poos: poos)}
  end

  @impl true
  def handle_event("pee", _event, socket) do
    Tracker.pee()
    {:noreply, socket}
  end

  @impl true
  def handle_event("poo", _event, socket) do
    Tracker.poo()
    {:noreply, socket}
  end

  @impl true
  def handle_info(%{event: "state", payload: %{state: {pees, poos}}}, socket) do
    {:noreply,
     assign(socket,
       pees: pees,
       poos: poos
     )}
  end
end
