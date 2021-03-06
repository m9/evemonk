# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class SystemDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      system_id: Field::Number,
      name_en: Field::String,
      name_de: Field::String,
      name_fr: Field::String,
      name_ja: Field::String,
      name_ru: Field::String,
      name_zh: Field::String,
      name_ko: Field::String,
      constellation: Field::BelongsTo.with_options(class_name: "Eve::Constellation"),
      star_id: Field::Number, # TODO: add star dashboard
      security_class: Field::String,
      security_status: Field::Number,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
      # stargates: Field::HasMany,
      # planets: Field::HasMany,
      # moons: Field::HasMany,
      # stations: Field::HasMany,
      # asteroid_belts: Field::HasMany,
      # position: Field::HasOne
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :system_id, :name_en].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :system_id,
      :name_en,
      :name_de,
      :name_fr,
      :name_ja,
      :name_ru,
      :name_zh,
      :name_ko,
      :constellation,
      :star_id,
      :security_class,
      :security_status,
      :created_at,
      :updated_at
      # :stargates,
      # :planets,
      # :moons,
      # :stations,
      # :asteroid_belts,
      # :position
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(system)
      system.name
    end
  end
end
