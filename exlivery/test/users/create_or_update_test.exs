defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    test "when all params are valid, saves the user" do
      UserAgent.start_link(%{})

      params = %{
        name: "Daniel",
        address: "Av Nove de Julho, 1952",
        email: "daniel@email.com",
        cpf: "12312312345",
        age: 27
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:ok, "User saved or update successfully"}

      assert response == expected_response
    end

    test "when some params are invalid, dont save the user" do
      UserAgent.start_link(%{})

      params = %{
        name: "Daniel",
        address: "Av Nove de Julho, 1952",
        email: "daniel@email.com",
        cpf: "12312312345",
        age: 17
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
