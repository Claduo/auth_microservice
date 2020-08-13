module AuthHelper
  AUTH_TOKEN = %r{\ABearer (?<token>.+)\z}

  def decoded_session_token
    JwtHelper.decode(get_encoded_token)
  rescue JWT::DecodeError
    {}
  end

  def get_encoded_token
    result = auth_header&.match(AUTH_TOKEN) || {}
    result[:token]
  end

  def auth_header
    request.env["HTTP_AUTHORIZATION"]
  end
end