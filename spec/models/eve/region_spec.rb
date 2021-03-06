# frozen_string_literal: true

require "rails_helper"

describe Eve::Region do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.translated_attribute_names).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_regions") }

  it { should have_many(:constellations).with_primary_key("region_id") }

  it { should have_many(:contracts).with_primary_key("region_id") }
end
