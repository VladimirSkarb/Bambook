class PlaceOffer
  include Interactor::Organizer
  # TODO: refactoring
  # organize ParseData, CreateOffer, FreezeMoney, CreateOfferSubscription
  organize ParseData, CreateOffer, CreateOfferSubscription
end
