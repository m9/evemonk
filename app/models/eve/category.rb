# frozen_string_literal: true

module Eve
  class Category < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name

    has_many :groups, primary_key: "category_id"

    scope :published, -> { where(published: true) }
  end
end
