class YakabooParser
  include Interactor

  def call
    MainParser.call(context)
    parsed_content = context.parsed_content

    context.params[:title] = parsed_content.css('#product-title > h1').inner_html
    context.params[:avatar] = parsed_content.css('#image').attr('src').text
    context.params[:price] = parsed_content.css('#price_stock_placeholder-top').text.gsub(/[^0-9]/, '').to_i
    context.params[:author] = parsed_content.css('div.product-attributes.product-attributes_short a').first.text
    context.delete_field(:parsed_content)
  end
end
