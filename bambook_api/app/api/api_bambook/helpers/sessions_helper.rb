module SessionsHelper
  def current_user
    begin
      @current_user ||= AuthorizeApiRequest.call(request.headers).result
    rescue
      puts 'Not authorized'
      @current_user = nil
    end
  end

  def logged_in?
    !current_user.nil?
  end
end