module ApiBambook
  module Helpers
    module MainHelper
      def declared_params
        @params ||= declared(params, include_missing: false)
      end

      def formatted_error!(code:, status:, message:)
        error = { error: true, code: code, message: message }
        error!(error, status)
      end

      def four_twenty_two!(error)
        formatted_error!(code: ApiCodes.invalid_or_missing_auth, status: 401, message: error.message)
      end

      def record_not_found!(error)
        formatted_error!(code: ApiCodes.not_found, status: 404, message: error.message)
      end

      def access_denied!(error)
        formatted_error!(code: ApiCodes.access_denied, status: 403, message: error.message)
      end
    end
  end
end

