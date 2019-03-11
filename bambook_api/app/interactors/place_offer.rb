class PlaceOffer
  include Interactor::Organizer
  # TODO: refactoring
  # organize ParseData, CreateOffer, FreezeMoney, CreateOfferSubscription
  # call parser interactor inside ParseData
  organize ParseData, CreateOffer, CreateOfferSubscription
end
