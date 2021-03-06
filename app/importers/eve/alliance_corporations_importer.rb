# frozen_string_literal: true

module Eve
  class AllianceCorporationsImporter
    attr_reader :alliance_id, :esi

    def initialize(alliance_id)
      @alliance_id = alliance_id
      @esi = EveOnline::ESI::AllianceCorporations.new(alliance_id: alliance_id)
    end

    def import
      esi.etag = etag.etag

      return if esi.not_modified?

      import_new_corporations

      remove_old_corporations

      etag.update!(etag: esi.etag, body: esi.response)
    rescue ActiveRecord::RecordNotFound
      Rails.logger.info("Alliance with ID #{alliance_id} not found")
    end

    private

    def import_new_corporations
      corporation_ids = esi.corporation_ids - eve_alliance.corporations.pluck(:corporation_id)

      corporation_ids.each do |corporation_id|
        Eve::UpdateCorporationJob.perform_later(corporation_id)
      end
    end

    def remove_old_corporations
      corporation_ids = eve_alliance.corporations.pluck(:corporation_id) - esi.corporation_ids

      corporation_ids.each do |corporation_id|
        Eve::UpdateCorporationJob.perform_later(corporation_id)
      end
    end

    def etag
      @etag ||= Eve::Etag.find_or_initialize_by(url: esi.url)
    end

    def eve_alliance
      @eve_alliance ||= Eve::Alliance.find_by!(alliance_id: alliance_id)
    end
  end
end
