class AuthRoutes < Application
  helpers AuthHelper

  post '' do
    result = Auths::AuthenticationService.call(decoded_session_token['uuid'])

    if result.success?
      status 201
      json auth: { user_id: result.user.id }
    else
      error_response(result.user || result.errors, 422)
    end
  end
end