module Auths
  class CreateSessionService
    prepend BasicService

    option :user_params do
      option :email
      option :password
    end

    option :user, default: proc { User.find(email: @user_params.email) }, reader: false

    attr_reader :session

    def call
      validate_password

      unless failure?
        @session = UserSession.new(user: @user)
        if session.valid?
          @session.save
        else
          fail!(@session.errors)
        end
      end
    end

    def validate_password
      is_password_valid = !!@user&.authenticate(@user_params.password)
      return fail!(I18n.t(:invalid_password, scope: 'services.errors.sessions')) unless is_password_valid
    end
  end
end