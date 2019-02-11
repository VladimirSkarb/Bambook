require 'pry'
module ApiBambook
  class Base < Grape::API
    prefix :api
    rescue_from :all
    #binding.pry
    mount ApiBambook::V1::Books
    mount ApiBambook::V1::Users

    add_swagger_documentation(
      api_version: 'v1',
      hide_documantation_path: true,
      hide_format: true,
      info: {
        title: 'API documentation'
      })
  end
end