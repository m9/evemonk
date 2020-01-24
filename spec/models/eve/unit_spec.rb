# frozen_string_literal: true

require "rails_helper"

describe Eve::Unit do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }
end