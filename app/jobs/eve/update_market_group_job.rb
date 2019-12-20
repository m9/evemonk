# frozen_string_literal: true

module Eve
  class UpdateMarketGroupJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError

    def perform(market_group_id)
      LanguageMapper::LANGUAGES.each_key do |locale|
        Eve::MarketGroupImporter.new(market_group_id, locale).import
      end
    end
  end
end