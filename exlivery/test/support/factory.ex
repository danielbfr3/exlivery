defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User

  def user_factory do
    %User{
      address: "Av Nove de Julho, 1952",
      age: 34,
      cpf: "122312312345",
      email: "daniel@teste.com",
      name: "Daniel Freire"
    }
  end

  def item_factory do
    %Item{
      category: :pizza,
      description: "Pizza de peperoni",
      quantity: 1,
      unit_price: Decimal.new("34.90")
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Av Nove de Julho, 1952",
      items: [
        build(:item),
        build(:item,
          description: "Temaki de atum",
          category: :japonesa,
          quantity: 2,
          unit_price: Decimal.new("15.00")
        )
      ],
      total_price: Decimal.new("64.90"),
      user_cpf: "122312312345"
    }
  end
end
