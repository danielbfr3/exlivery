defmodule Exlivery.Orders.Agent do
  alias Exlivery.Orders.Order

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Order{} = order) do
    uuid = UUID.uuid4()
    Agent.update(__MODULE__, &update_state(&1, uuid, order))
    {:ok, uuid}
  end

  def get(uuid) do
    Agent.get(__MODULE__, &get_order(&1, uuid))
  end

  def list_all, do: Agent.get(__MODULE__, & &1)

  defp update_state(state, uuid, %Order{} = order) do
    state
    |> Map.put(uuid, order)
  end

  defp get_order(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "Order not found"}
      order -> {:ok, order}
    end
  end
end
