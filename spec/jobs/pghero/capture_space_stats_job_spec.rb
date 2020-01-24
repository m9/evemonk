# frozen_string_literal: true

require "rails_helper"

describe Pghero::CaptureSpaceStatsJob do
  it { expect(described_class.queue_name).to eq("pghero") }

  describe "#perform" do
    before { expect(PgHero).to receive(:capture_space_stats) }

    specify { expect { subject.perform }.not_to raise_error }
  end
end