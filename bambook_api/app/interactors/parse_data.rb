class ParseData
  include Interactor

  def call
    # TODO: refactoring
    # call parser interactor

    # Fake data
    context.params[:price] = 200
    context.params[:avatar] = 'https://img.yakaboo.ua/media/catalog/product/cache/1/image/398x565/234c7c011ba026e66d29567e1be1d1f7/4/8/48280_78694.jpg'
    context.params[:title] = 'Origin'
    context.params[:author] = 'Dan Brown'
  end
end