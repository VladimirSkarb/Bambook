class AuthenticateUser
  include Interactor

  def call
    context.access_token = JsonWebToken.encode(user_id: user.id) if user
  end

  private

  def user
    user = User.find_by(email: context.email)
    if user&.authenticate(context.password)
      user
    else
      context.fail!
    end
  end
end
