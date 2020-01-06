# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalConstellationsJob do
  it { expect(described_class.queue_name).to eq("default") }

  describe "#perform" do
    before do
      #
      # Eve::LocalConstellationsImporter.new.import
      #
      expect(Eve::LocalConstellationsImporter).to receive(:new) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform }.not_to raise_error }
  end
end
