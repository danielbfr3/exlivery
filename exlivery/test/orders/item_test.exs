defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case
  alias Exlivery.Orders.Item
  import Exlivery.Factory

  describe "build/4" do
    test "when our params are valid it must returns a item" do
      %Item{
        description: description,
        category: category,
        unit_price: unit_price,
        quantity: quantity
      } = build(:item)

      response =
        Item.build(
          description,
          category,
          unit_price,
          quantity
        )

      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "when there is a invalid category, returns a error" do
      %Item{
        description: description,
        category: category,
        unit_price: unit_price,
        quantity: quantity
      } = build(:item, category: :arabe)

      response =
        Item.build(
          description,
          category,
          unit_price,
          quantity
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when there is a invalid price, returns a error" do
      %Item{
        description: description,
        category: category,
        unit_price: unit_price,
        quantity: quantity
      } = build(:item, unit_price: "price")

      response =
        Item.build(
          description,
          category,
          unit_price,
          quantity
        )

      expected_response = {:error, "Invalid price"}

      assert response == expected_response
    end

    test "when there is a invalid quantity, returns a error" do
      %Item{
        description: description,
        category: category,
        unit_price: unit_price,
        quantity: quantity
      } = build(:item, quantity: 0)

      response =
        Item.build(
          description,
          category,
          unit_price,
          quantity
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
