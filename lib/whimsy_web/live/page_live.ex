defmodule WhimsyWeb.PageLive do
  use WhimsyWeb, :live_view
  alias Whimsy.Tracker

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      WhimsyWeb.Endpoint.subscribe("tracker")
    end

    {:ok, assign(socket, times: Tracker.state())}
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
  def handle_info(%{event: "state", payload: %{state: times}}, socket) do
    {:noreply,
     assign(socket,
       times: times
     )}
  end
end
