defmodule Exlivery.Users.CreateOrUpdate do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  def call(%{name: name, email: email, cpf: cpf, age: age, address: address}) do
    address
    |> User.build(name, email, cpf, age)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)
    {:ok, "User saved or update successfully"}
  end

  defp save_user({:error, _reason} = error), do: error
end
