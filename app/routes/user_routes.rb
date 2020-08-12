class UserRoutes < Application
  post '' do
    signup_params = validate_with!(SignupParamsContract)
    result = Auths::CreateUserService.call(user_params: signup_params.to_h)

    if result.success?
      status 201
      json succes: true
    else
      error_response(result.user || result.errors, 422)
    end
  end
end