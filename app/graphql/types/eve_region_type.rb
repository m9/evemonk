# frozen_string_literal: true

module Types
  class EveRegionType < Types::BaseObject
    field :id, ID, null: false
    field :name, GraphQL::Types::JSON, null: true
    field :description, GraphQL::Types::JSON, null: true
    field :constellations, Types::EveConstellationType.connection_type, null: true
    field :contracts, Types::EveContractType.connection_type, null: true

    def id
      object.region_id
    end

    def name
      {
        en: object.name_en,
        de: object.name_de,
        fr: object.name_fr,
        ja: object.name_ja,
        ru: object.name_ru,
        zh: object.name_zh,
        ko: object.name_ko
      }
    end

    def description
      {
        en: object.description_en,
        de: object.description_de,
        fr: object.description_fr,
        ja: object.description_ja,
        ru: object.description_ru,
        zh: object.description_zh,
        ko: object.description_ko
      }
    end
  end
end
