class SubscribeOffer
  include Interactor::Organizer

  organize FreezeMoney, CreateOfferSubscription
end