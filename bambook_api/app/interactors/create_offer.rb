class CreateOffer
  include Interactor

  def call
    user = context.user
    offer = user.offers.new(context.params)
    offer.status = 0

    if offer.save
      context.offer = offer
    else
      context.errors = offer.errors.messages
      context.fail!
    end
  end
end
