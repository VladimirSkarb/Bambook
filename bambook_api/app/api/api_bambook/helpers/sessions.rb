module Sessions
  def current_user
    begin
      @current_user = AuthorizeApiRequest.call(request.headers).result
    rescue
      puts 'Not authorized'
      @current_user = nil
    end
  end
end