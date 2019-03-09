class AuthorizeApiRequest
  include Interactor

  def call
    user
  end

  private

  def user
    user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    context.user = user
  end

  def decoded_auth_token
    return unless http_auth_header

    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    context.Authorization if context.Authorization.present?
  end
end
