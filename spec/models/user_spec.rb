# frozen_string_literal: true

require "rails_helper"

describe User do
  it { should be_an(ApplicationRecord) }

  it {
    expect(described_class.devise_modules).to eq([:database_authenticatable,
      :rememberable,
      :recoverable,
      :registerable,
      :validatable,
      :confirmable,
      :trackable,
      :authy_authenticatable])
  }

  it { should have_many(:sessions).dependent(:destroy) }

  it { should have_many(:characters).dependent(:destroy) }

  it {
    should define_enum_for(:locale).with_values(auto_detect: 0,
                                                english: 1,
                                                german: 2,
                                                french: 3,
                                                japanese: 4,
                                                russian: 5,
                                                chinese: 6,
                                                korean: 7)
  }
end
