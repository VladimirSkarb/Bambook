class PlaceOffer
  include Interactor::Organizer

  organize ParseData, CreateOffer, FreezeMoney, CreateTransaction, CreateOfferSubscription
end
