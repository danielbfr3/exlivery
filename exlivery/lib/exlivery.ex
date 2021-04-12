defmodule Exlivery do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.CreateOrUpdate, as: CreateOrUpdateOrder
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_agents do
    user_agent = UserAgent.start_link(%{})
    order_agent = OrderAgent.start_link(%{})
    {user_agent, order_agent}
  end

  defdelegate get_user(cpf), to: UserAgent, as: :get
  defdelegate create_or_update_user(params), to: CreateOrUpdateUser, as: :call

  defdelegate get_order(uuid), to: OrderAgent, as: :get
  defdelegate create_or_update_order(params), to: CreateOrUpdateOrder, as: :call
end
