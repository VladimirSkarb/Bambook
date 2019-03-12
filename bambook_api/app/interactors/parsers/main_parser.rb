class MainParser
  include Interactor

  def call
    url = context.params[:link]
    document = open(url)
    content = document.read
    context.parsed_content = Nokogiri::HTML(content)
  end
end