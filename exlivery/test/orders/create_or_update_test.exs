defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Exlivery.start_agents()

      cpf = "12345678910"
      user = build(:user, cpf: cpf)
      UserAgent.save(user)

      item1 = build(:item)

      item2 =
        build(
          :item,
          category: :bebida,
          description: "Coca-Cola 600ml",
          quantity: 2,
          unit_price: Decimal.new("6.99")
        )

      invalid_item =
        build(
          :item,
          category: :brinquedo,
          description: "Coca-Cola 600ml",
          quantity: 2,
          unit_price: Decimal.new("6.99")
        )

      {:ok, user_cpf: cpf, items: [item1, item2], invalid_item: invalid_item}
    end

    test "when params are valid, save the order", %{user_cpf: cpf, items: items} do
      params = %{user_cpf: cpf, items: items}

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "when there is no user with the given cpf, do not save the order", %{
      items: items
    } do
      params = %{user_cpf: "11122211144", items: items}

      response = CreateOrUpdate.call(params)

      assert {:error, _reason} = response
    end

    test "when there is some invalid items, do not save the order", %{
      user_cpf: cpf,
      invalid_item: invalid_item
    } do
      params = %{user_cpf: cpf, items: [invalid_item]}

      response = CreateOrUpdate.call(params)

      assert {:error, _uuid} = response
    end
  end
end
