module Authenticable
  def current_user
    return @current_user if @current_user

    header = request.headers

    return nil if header.nil?

    @current_user = (AuthorizeApiRequest.new(header).call)
  end

  protected

  def check_login
    head :forbidden unless self.current_user
  end
end
