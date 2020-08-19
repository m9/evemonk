# frozen_string_literal: true

module Types
  class EveCategoryType < Types::BaseObject
    field :id, ID, null: false
    field :name, GraphQL::Types::JSON, null: true
    field :published, Boolean, null: true
    field :groups, [Types::EveGroupType], null: true

    def id
      object.category_id
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
  end
end