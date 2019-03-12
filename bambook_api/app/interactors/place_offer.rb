class PlaceOffer
  include Interactor::Organizer

  organize ParseData, CreateOffer, FreezeMoney, CreateOfferSubscription
end
