# frozen_string_literal: true

module Eve
  class CharacterAttribute < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name

    belongs_to :icon,
      class_name: "Eve::Icon",
      primary_key: "icon_id",
      optional: true
  end
end
