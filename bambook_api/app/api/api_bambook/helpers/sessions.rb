module Sessions
  def current_user
    @current_user = AuthorizeApiRequest.call(request.headers).result
  end
end