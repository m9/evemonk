# frozen_string_literal: true

require "rails_helper"

describe Eve::AsteroidBelt do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { should have_one(:position).dependent(:destroy) }
end
