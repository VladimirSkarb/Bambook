module ApiBambook
  module V1
    class Main < Base
      version 'v1', using: :path, parameter: 'api_bambook'
      format :json

      helpers ApiBambook::Helpers::MainHelper
      helpers ApiBambook::Helpers::SessionsHelper
      helpers Pundit

      rescue_from ActiveRecord::RecordInvalid,
                  ExceptionHandler::MissingToken,
                  ExceptionHandler::InvalidToken,
                  ExceptionHandler::ExpiredSignature,
                  ExceptionHandler::DecodeError,
                  ExceptionHandler::AuthenticationError, ->(error) { four_twenty_two!(error) }

      rescue_from ActiveRecord::RecordNotFound, ->(error) { record_not_found!(error) }
      rescue_from Pundit::NotAuthorizedError, ->(error) { access_denied!(error) }

      before { current_user }

      mount ApiBambook::V1::Books
      mount ApiBambook::V1::Users
    end
  end
end
