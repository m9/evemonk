# frozen_string_literal: true

module Eve
  class UpdateCategoryJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError

    def perform(category_id)
      LanguageMapper::LANGUAGES.each_key do |locale|
        Eve::CategoryImporter.new(category_id, locale).import
      end
    end
  end
end