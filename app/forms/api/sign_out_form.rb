# frozen_string_literal: true

module Api
  class SignOutForm
    include ActionController::HttpAuthentication::Token

    def initialize(request)
      @request = request
    end

    def destroy!
      token, = token_and_options(@request)

      session = Session.find_by!(token: token)

      session.destroy!
    end
  end
end
