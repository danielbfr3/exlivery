defmodule Exlivery.Users.UserTest do
  use ExUnit.Case
  alias Exlivery.Users.User
  import Exlivery.Factory

  describe "build/5" do
    test "when our params are valid" do
      %User{
        address: address,
        name: name,
        email: email,
        cpf: cpf,
        age: age
      } = build(:user)

      response =
        User.build(
          address,
          name,
          email,
          cpf,
          age
        )

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when our age is less than 18" do
      %User{
        address: address,
        name: name,
        email: email,
        cpf: cpf,
        age: age
      } = build(:user, age: 17)

      response =
        User.build(
          address,
          name,
          email,
          cpf,
          age
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when cpf is not a string of numbers" do
      %User{
        address: address,
        name: name,
        email: email,
        cpf: cpf,
        age: age
      } = build(:user, cpf: 12_312_312_345)

      response =
        User.build(
          address,
          name,
          email,
          cpf,
          age
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
