defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent

  import Exlivery.Factory

  describe "save/1" do
    test "saves the order" do
      order = build(:order)
      OrderAgent.start_link(%{})

      response = OrderAgent.save(order)
      {:ok, uuid} = response

      expected_response = {:ok, uuid}

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(%{})
      order = build(:order)
      {:ok, uuid} = OrderAgent.save(order)

      {:ok, %{uuid: uuid, order: order}}
    end

    test "when the user is found, returns the user", %{uuid: uuid, order: order} do
      response = OrderAgent.get(uuid)

      expected_response = {:ok, order}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      response = OrderAgent.get("00000000000")

      expected_response = {:error, "Order not found"}

      assert response == expected_response
    end
  end
end
