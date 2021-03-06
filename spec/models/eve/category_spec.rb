# frozen_string_literal: true

require "rails_helper"

describe Eve::Category do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.translated_attribute_names).to eq(["name"]) }

  it { expect(described_class.table_name).to eq("eve_categories") }

  it { should have_many(:groups).with_primary_key("category_id") }

  describe ".published" do
    let!(:eve_category1) { create(:eve_category, published: false) }

    let!(:eve_category2) { create(:eve_category, published: true) }

    specify { expect(described_class.published.count).to eq(1) }

    specify { expect(described_class.published).to eq([eve_category2]) }
  end
end
