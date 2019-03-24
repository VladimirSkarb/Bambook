class FreezeMoney
  include Interactor

  def call
    user_money = context.user.wallet[:available_money]
    user_frozen_money = context.user.wallet[:frozen_money]
    context.offer_contribution = context.offer[:contribution]

    if user_money > context.offer_contribution
      rest_money = user_money - context.offer_contribution
      frozen_money = user_frozen_money + context.offer_contribution
      context.user.wallet.update(available_money: rest_money, frozen_money: frozen_money)
      context.operation_code = 2
    else
      context.errors = 'dont have enough money'
      context.fail!
    end
  end
end
