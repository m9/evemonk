# frozen_string_literal: true

require "rails_helper"

describe IndustryJobDecorator do
  subject { described_class.new(double) }

  it { should be_a(ApplicationDecorator) }
end
