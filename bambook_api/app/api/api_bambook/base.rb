module ApiBambook
  class Base < Grape::API
    include ExceptionHandler
    helpers SessionsHelper
    prefix :api

    mount ApiBambook::V1::Main

    add_swagger_documentation(
      api_version: 'v1',
      hide_documantation_path: true,
      hide_format: true,
      info: {
        title: 'API documentation'
      }
    )
  end
end
