module ApiBambook
  module V1
    class Main < Base
      version 'v1', using: :path, parameter: 'api_bambook'
      format :json
      # rescue_from :all
      before do
        current_user
      end

      mount ApiBambook::V1::Books
      mount ApiBambook::V1::Users
    end
  end
end
