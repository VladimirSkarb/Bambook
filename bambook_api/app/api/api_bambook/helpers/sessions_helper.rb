module ApiBambook
  module Helpers
    module SessionsHelper
      # Returns the current logged-in user (if any).
      def current_user
        @current_user ||= AuthorizeApiRequest.call(request.headers).result
      end

      # Returns true if the user is logged in, false otherwise.
      def logged_in?
        !current_user.nil?
      end

      # Returns true if the given user is the current user.
      def is_owner(user)
        user == current_user
      end
    end
  end
end