class SubscribeOffer
  include Interactor::Organizer

  organize FreezeMoney, CreateTransaction, CreateOfferSubscription
end