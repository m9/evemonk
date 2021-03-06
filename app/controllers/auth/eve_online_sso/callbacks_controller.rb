# frozen_string_literal: true

module Auth
  module EveOnlineSso
    class CallbacksController < ApplicationController
      rescue_from EveOnline::Exceptions::ServiceUnavailable, with: :handle_service_unavailable

      rescue_from EveOnline::Exceptions::InternalServerError, with: :handle_internal_server_error

      rescue_from EveOnline::Exceptions::BadGateway, with: :handle_bad_gateway

      rescue_from EveOnline::Exceptions::Timeout, with: :handle_timeout

      def show
        service = EveOnlineCallbackService.new(current_user, request)

        service.save!

        redirect_to characters_path
      end

      private

      def handle_service_unavailable
        render inline: "Service Unavailable (503). Please, try again later."
      end

      def handle_internal_server_error
        render inline: "Internal Server Error (500). Please, try again later."
      end

      def handle_bad_gateway
        render inline: "Bad Gateway (502). Please, try again later."
      end

      def handle_timeout
        render inline: "Timeout Error. Please, try again later."
      end
    end
  end
end
