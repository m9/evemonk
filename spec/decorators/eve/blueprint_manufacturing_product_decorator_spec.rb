# frozen_string_literal: true

require "rails_helper"

describe Eve::BlueprintManufacturingProductDecorator do
  subject { described_class.new(double) }

  it { should be_an(ApplicationDecorator) }
end
