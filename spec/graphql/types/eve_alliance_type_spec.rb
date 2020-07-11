# frozen_string_literal: true

require "rails_helper"

describe Types::EveAllianceType do
  describe "alliances" do
    before { travel_to Time.zone.now }

    after { travel_back }

    let(:date_founded1) { Time.zone.now }

    let(:date_founded2) { Time.zone.now - 1.week }

    let!(:create_corporation1) do
      create(:eve_corporation,
        corporation_id: 222)
    end

    let!(:create_corporation2) do
      create(:eve_corporation,
             corporation_id: 333)
    end

    let!(:creator1) do
      create(:eve_character,
        character_id: 4_444)
    end

    let!(:creator2) do
      create(:eve_character,
        character_id: 5_555)
    end

    let!(:eve_alliance1) do
      create(:eve_alliance,
        alliance_id: 123,
        name: "Alliance 1",
        ticker: "ALLIANCE1",
        date_founded: date_founded1,
        creator_corporation: create_corporation1,
        creator: creator1)
    end

    let!(:eve_alliance2) do
      create(:eve_alliance,
        alliance_id: 321,
        name: "Alliance 2",
        ticker: "ALLIANCE2",
        date_founded: date_founded2,
        creator_corporation: create_corporation2,
        creator: creator2)
    end

    let(:query) do
      %(
        {
          alliances {
            id
            name
            ticker
            dateFounded
            creatorCorporationId
            creatorCorporation {
              id
            }
            creatorId
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "alliances" => [
          {
            "id" => "123",
            "name" => "Alliance 1",
            "ticker" => "ALLIANCE1",
            "dateFounded" => Time.zone.now.iso8601,
            "creatorCorporationId" => 222,
            "creatorCorporation" => {
              "id" => "222"
            },
            "creatorId" => 4444
          },
          {
            "id" => "321",
            "name" => "Alliance 2",
            "ticker" => "ALLIANCE2",
            "dateFounded" => (Time.zone.now - 1.week).iso8601,
            "creatorCorporationId" => 333,
            "creatorCorporation" => {
              "id" => "333"
            },
            "creatorId" => 5555
          }
        ]
      })
    end
  end
end
