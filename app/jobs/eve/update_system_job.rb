# frozen_string_literal: true

module Eve
  class UpdateSystemJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError,
      OpenSSL::SSL::SSLError,
      Faraday::Error::TimeoutError

    def perform(system_id)
      LanguageMapper::LANGUAGES.each_key do |locale|
        Eve::SystemImporter.new(system_id, locale).import
      end
    end
  end
end