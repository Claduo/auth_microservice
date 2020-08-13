class UserSessionRoutes < Application
  post '/' do
    login_params = validate_with!(LoginParamsContract)
    result = Auths::CreateSessionService.call(user_params: login_params.to_h)

    if result.success?
      token = JwtEncoder.encode(uuid: result.session.uuid)
      status 201
      json auth: { token: token }
    else
      error_response(result.session || result.errors, 401)
    end
  end
end