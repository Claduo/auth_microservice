module JwtHelper
  extend self

  SECRET = Settings.secret_code

  def encode(string)
    JWT.encode(string, SECRET)
  end

  def decode(token)
    JWT.decode(token, SECRET).first
  end
end