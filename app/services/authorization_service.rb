class AuthorizationService
  def initialize(headers = {})
    @headers = headers
  end

  def current_user
    @auth_payload, @auth_header = verify_token
    @user = User.from_token_payload(@auth_payload)
    sub = @auth_payload['sub']
    unless Rails.cache.read("user_#{sub}")
      Rails.cache.write("user_#{sub}", @current_user, expires_in: 2.hours)
    end
  end

  def cached_user
    return unless http_token
    decode_payload = decode_token[0]
    sub = decode_payload['sub']
    @cached_user = Rails.cache.read("user_#{sub}")
    Rails.cache.write("user_#{sub}", @cached_user, expires_in: 2.hours)
  end

  private

  def http_token
    @headers['Authorization'].split(' ').last if @headers['Authorization'].present?
  end

  def verify_token
    JsonWebToken.verify(http_token)
  end

  def decode_token
    JsonWebToken.decode(http_token)
  end
end
