# frozen_string_literal: true

module Eve
  class UpdateGraphicJob < ActiveJob::Base
    queue_as :default

    retry_on EveOnline::Exceptions::Timeout,
      EveOnline::Exceptions::ServiceUnavailable,
      EveOnline::Exceptions::BadGateway,
      EveOnline::Exceptions::InternalServerError

    def perform(graphic_id)
      Eve::GraphicImporter.new(graphic_id).import
    end
  end
end