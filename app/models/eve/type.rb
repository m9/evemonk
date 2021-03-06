# frozen_string_literal: true

module Eve
  class Type < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name, :description

    searchkick word_start: [:name_en, :name_de, :name_fr, :name_ja, :name_ru,
      :name_zh, :name_ko]

    belongs_to :graphic,
      primary_key: "graphic_id",
      optional: true

    belongs_to :group,
      primary_key: "group_id",
      optional: true

    belongs_to :icon,
      primary_key: "icon_id",
      optional: true

    belongs_to :market_group,
      primary_key: "market_group_id",
      optional: true

    has_many :type_dogma_attributes,
      primary_key: "type_id",
      foreign_key: "type_id",
      dependent: :destroy

    has_many :dogma_attributes,
      through: :type_dogma_attributes

    # TODO: import
    has_many :type_dogma_effects,
      primary_key: "type_id",
      foreign_key: "type_id",
      dependent: :destroy

    # TODO: import
    # has_many :dogma_effects,
    #   through: :type_dogma_effects

    scope :published, -> { where(published: true) }

    def search_data
      {
        name_en: name_en,
        name_de: name_de,
        name_fr: name_fr,
        name_ja: name_ja,
        name_ru: name_ru,
        name_zh: name_zh,
        name_ko: name_ko,
        published: published,
        is_blueprint: is_blueprint,
        is_manufacturing_item: is_manufacturing_item
      }
    end

    def implant_bonuses
      @implant_bonuses ||= ImplantBonuses.new(self).implant_bonuses
    end
  end
end
