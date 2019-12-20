# frozen_string_literal: true

module Eve
  class UpdateGraphicsJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError

    def perform
      Eve::GraphicsImporter.new.import
    end
  end
end