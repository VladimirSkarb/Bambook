class CreateOfferSubscription
  include Interactor

  def call
    offer = context.offer
    offer_subscription = offer.offer_subscriptions.build(user: context.user)

    if offer_subscription.save
      context.subscriptions = offer_subscription
    else
      context.errors = offer_subscription.errors.messages
      context.fail!
    end
  end
end