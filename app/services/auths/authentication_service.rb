module Auths
  class AuthenticationService

    prepend BasicService

    param :uuid

    attr_reader :user

    def call
      if @uuid.blank? || session.blank?
        fail!(I18n.t(:forbidden, scope: 'services.auth.fetch_user_service'))
      else
        @user = session.user
      end
    end

    private

    def session
      @session ||= UserSession.find(uuid: @uuid)
    end
  end
end
