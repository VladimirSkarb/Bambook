module ApiBambook
  class BaseApi < Grape::API
    prefix :api
    include Pundit
    include Grape::Kaminari

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
