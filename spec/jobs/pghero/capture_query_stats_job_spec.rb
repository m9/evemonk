# frozen_string_literal: true

require "rails_helper"

describe Pghero::CaptureQueryStatsJob do
  it { should be_an(ApplicationJob) }

  it { expect(described_class.queue_name).to eq("pghero") }

  describe "#perform" do
    before { expect(PgHero).to receive(:capture_query_stats) }

    specify { expect { subject.perform }.not_to raise_error }
  end
end
