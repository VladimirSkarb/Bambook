module ApiBambook
  module V1
    class Main < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api
      include ExceptionHandler
    end
  end
end
