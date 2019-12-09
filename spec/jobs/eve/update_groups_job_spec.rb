# frozen_string_literal: true

require "rails_helper"

describe Eve::UpdateGroupsJob do
  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    before do
      #
      # Eve::GroupsImporter.new(page).import
      #
      expect(Eve::GroupsImporter).to receive(:new).with(1) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    subject { described_class.new }

    specify { expect { subject.perform }.not_to raise_error }
  end
end
