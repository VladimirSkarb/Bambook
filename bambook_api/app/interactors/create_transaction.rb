class CreateTransaction
  include Interactor

  def call
    operation_code = context.operation_code
    amount = context.offer_contribution
    transaction = context.user.wallet.money_transactions.new(operation: operation_code, amount: amount)

    if transaction.save
      context.transaction = transaction
    else
      context.errors = transaction.errors.messages
      context.fail!
    end
  end
end
