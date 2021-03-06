# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterCorporationHistory do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_character_corporation_histories") }

  it { should belong_to(:character).class_name("Eve::Character").with_primary_key("character_id") }

  it { should belong_to(:corporation).class_name("Eve::Corporation").with_primary_key("corporation_id").optional(true) }
end
