require 'pry'
class AuthenticateUser
  prepend SimpleCommand
  attr_accessor :email, :password

  #this is where parameters are taken when the command is called
  def initialize(user_params)
    @email = user_params[:email]
    @password = user_params[:password]
  end

  #this is where the result gets returned
  def call
    #binding.pry
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  def user
    user = User.find_by(email: email)
    if user&.authenticate(password)
      user
    else
      errors.add :user_authentication, 'Invalid credentials'
    end
  end
end