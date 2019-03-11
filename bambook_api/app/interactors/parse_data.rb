class ParseData
  include Interactor

  def call
    site = context.params[:link]

    if site.include?('yakaboo')
      YakabooParser.call(context)
    else
      context.errors = 'Undefined sourse'
      context.fail!
    end
  end
end