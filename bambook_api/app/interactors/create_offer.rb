class CreateOffer
  include Interactor

  def call
    user = context.user
    offer = user.offers.new(context.params)
    offer.status = 0
    offer.contribution = ((offer.price / offer.minimum_quantity) * 1.1).round(2)

    if offer.save
      context.offer = offer
    else
      context.errors = offer.errors.messages
      context.fail!
    end
  end
end
