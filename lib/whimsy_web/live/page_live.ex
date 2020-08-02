defmodule WhimsyWeb.PageLive do
  use WhimsyWeb, :live_view
  alias Whimsy.Tracker

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      WhimsyWeb.Endpoint.subscribe("tracker")
    end

    {:ok, assign(socket, times: Tracker.times())}
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
  def handle_event("meal", _event, socket) do
    Tracker.meal()
    {:noreply, socket}
  end

  @impl true
  def handle_event("bath", _event, socket) do
    Tracker.bath()
    {:noreply, socket}
  end

  @impl true
  def handle_event("emergency", _event, socket) do
    Tracker.emergency()
    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    id
    |> String.to_integer()
    |> Tracker.delete()

    {:noreply, socket}
  end

  @impl true
  def handle_info(%{event: "times", payload: %{times: times}}, socket) do
    {:noreply,
     assign(socket,
       times: times
     )}
  end
end
