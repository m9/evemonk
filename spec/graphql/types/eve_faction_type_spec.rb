# frozen_string_literal: true

require "rails_helper"

describe Types::EveFactionType do
  describe "get factions" do
    let!(:eve_corporation1) do
      create(:eve_corporation,
        corporation_id: 1_111)
    end

    let!(:eve_corporation2) do
      create(:eve_corporation,
        corporation_id: 1_222)
    end

    let!(:eve_militia_corporation1) do
      create(:eve_corporation,
        corporation_id: 2_111)
    end

    let!(:eve_militia_corporation2) do
      create(:eve_corporation,
        corporation_id: 2_222)
    end

    let!(:eve_system1) do
      create(:eve_system,
        system_id: 10_111)
    end

    let!(:eve_system2) do
      create(:eve_system,
        system_id: 10_222)
    end

    let!(:eve_alliance1) do
      create(:eve_alliance,
        alliance_id: 12_345,
        faction: eve_faction1)
    end

    let!(:eve_alliance2) do
      create(:eve_alliance,
        alliance_id: 67_890,
        faction: eve_faction2)
    end

    let!(:eve_faction1) do
      create(:eve_faction,
        faction_id: 123,
        name_en: "EN: name 1",
        name_de: "DE: name 1",
        name_fr: "FR: name 1",
        name_ja: "JA: name 1",
        name_ru: "RU: name 1",
        name_zh: "ZH: name 1",
        name_ko: "KO: name 1",
        corporation: eve_corporation1,
        description_en: "EN: description 1",
        description_de: "DE: description 1",
        description_fr: "FR: description 1",
        description_ja: "JA: description 1",
        description_ru: "RU: description 1",
        description_zh: "ZH: description 1",
        description_ko: "KO: description 1",
        is_unique: true,
        militia_corporation: eve_militia_corporation1,
        solar_system: eve_system1,
        station_count: 100,
        station_system_count: 1_000)
    end

    let!(:eve_faction2) do
      create(:eve_faction,
        faction_id: 321,
        name_en: "EN: name 2",
        name_de: "DE: name 2",
        name_fr: "FR: name 2",
        name_ja: "JA: name 2",
        name_ru: "RU: name 2",
        name_zh: "ZH: name 2",
        name_ko: "KO: name 2",
        corporation: eve_corporation2,
        description_en: "EN: description 2",
        description_de: "DE: description 2",
        description_fr: "FR: description 2",
        description_ja: "JA: description 2",
        description_ru: "RU: description 2",
        description_zh: "ZH: description 2",
        description_ko: "KO: description 2",
        is_unique: false,
        militia_corporation: eve_militia_corporation2,
        solar_system: eve_system2,
        station_count: 200,
        station_system_count: 2_000)
    end

    let(:query) do
      %(
        {
          factions(first: 2) {
            edges {
              node {
                id
                corporationId
                corporation {
                  id
                }
                description
                isUnique
                name
                militiaCorporationId
                militiaCorporation {
                  id
                }
                sizeFactor
                solarSystemId
                solarSystem {
                  id
                }
                stationCount
                stationSystemCount
                alliances(first: 1) {
                  edges {
                    node {
                      id
                    }
                    cursor
                  }
                  pageInfo {
                    endCursor
                    hasNextPage
                    hasPreviousPage
                    startCursor
                  }
                }
              }
              cursor
            }
            pageInfo {
              endCursor
              hasNextPage
              hasPreviousPage
              startCursor
            }
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "factions" => {
          "edges" => [
            {
              "node" => {
                "id" => "123",
                "corporationId" => 1_111,
                "corporation" => {
                  "id" => "1111"
                },
                "description" => {
                  "en" => "EN: description 1",
                  "de" => "DE: description 1",
                  "fr" => "FR: description 1",
                  "ja" => "JA: description 1",
                  "ru" => "RU: description 1",
                  "zh" => "ZH: description 1",
                  "ko" => "KO: description 1"
                },
                "isUnique" => true,
                "name" => {
                  "en" => "EN: name 1",
                  "de" => "DE: name 1",
                  "fr" => "FR: name 1",
                  "ja" => "JA: name 1",
                  "ru" => "RU: name 1",
                  "zh" => "ZH: name 1",
                  "ko" => "KO: name 1"
                },
                "militiaCorporationId" => 2_111,
                "militiaCorporation" => {
                  "id" => "2111"
                },
                "sizeFactor" => 1.5,
                "solarSystemId" => 10_111,
                "solarSystem" => {
                  "id" => "10111"
                },
                "stationCount" => 100,
                "stationSystemCount" => 1_000,
                "alliances" => {
                  "edges" => [
                    {
                      "node" => {
                        "id" => "12345"
                      },
                      "cursor" => "MQ"
                    }
                  ],
                  "pageInfo" => {
                    "endCursor" => "MQ",
                    "hasNextPage" => false,
                    "hasPreviousPage" => false,
                    "startCursor" => "MQ"
                  }
                }
              },
              "cursor" => "MQ"
            },
            {
              "node" => {
                "id" => "321",
                "corporationId" => 1_222,
                "corporation" => {
                  "id" => "1222"
                },
                "description" => {
                  "en" => "EN: description 2",
                  "de" => "DE: description 2",
                  "fr" => "FR: description 2",
                  "ja" => "JA: description 2",
                  "ru" => "RU: description 2",
                  "zh" => "ZH: description 2",
                  "ko" => "KO: description 2"
                },
                "isUnique" => false,
                "name" => {
                  "en" => "EN: name 2",
                  "de" => "DE: name 2",
                  "fr" => "FR: name 2",
                  "ja" => "JA: name 2",
                  "ru" => "RU: name 2",
                  "zh" => "ZH: name 2",
                  "ko" => "KO: name 2"
                },
                "militiaCorporationId" => 2_222,
                "militiaCorporation" => {
                  "id" => "2222"
                },
                "sizeFactor" => 1.5,
                "solarSystemId" => 10_222,
                "solarSystem" => {
                  "id" => "10222"
                },
                "stationCount" => 200,
                "stationSystemCount" => 2_000,
                "alliances" => {
                  "edges" => [
                    {
                      "node" => {
                        "id" => "67890"
                      },
                      "cursor" => "MQ"
                    }
                  ],
                  "pageInfo" => {
                    "endCursor" => "MQ",
                    "hasNextPage" => false,
                    "hasPreviousPage" => false,
                    "startCursor" => "MQ"
                  }
                }
              },
              "cursor" => "Mg"
            }
          ],
          "pageInfo" => {
            "endCursor" => "Mg",
            "hasNextPage" => false,
            "hasPreviousPage" => false,
            "startCursor" => "MQ"
          }
        }
      })
    end
  end

  describe "get faction by id" do
    let!(:eve_corporation) do
      create(:eve_corporation,
        corporation_id: 1_111)
    end

    let!(:eve_militia_corporation) do
      create(:eve_corporation,
        corporation_id: 2_111)
    end

    let!(:eve_system) do
      create(:eve_system,
        system_id: 10_111)
    end

    let!(:eve_alliance) do
      create(:eve_alliance,
        alliance_id: 12_345,
        faction: eve_faction)
    end

    let!(:eve_faction) do
      create(:eve_faction,
        faction_id: 123,
        name_en: "EN: name 1",
        name_de: "DE: name 1",
        name_fr: "FR: name 1",
        name_ja: "JA: name 1",
        name_ru: "RU: name 1",
        name_zh: "ZH: name 1",
        name_ko: "KO: name 1",
        corporation: eve_corporation,
        description_en: "EN: description 1",
        description_de: "DE: description 1",
        description_fr: "FR: description 1",
        description_ja: "JA: description 1",
        description_ru: "RU: description 1",
        description_zh: "ZH: description 1",
        description_ko: "KO: description 1",
        is_unique: true,
        militia_corporation: eve_militia_corporation,
        solar_system: eve_system,
        station_count: 100,
        station_system_count: 1_000)
    end

    let(:query) do
      %(
        {
          faction(id: 123) {
            id
            corporationId
            corporation {
              id
            }
            description
            isUnique
            name
            militiaCorporationId
            militiaCorporation {
              id
            }
            sizeFactor
            solarSystemId
            solarSystem {
              id
            }
            stationCount
            stationSystemCount
            alliances(first: 1) {
              edges {
                node {
                  id
                }
                cursor
              }
              pageInfo {
                endCursor
                hasNextPage
                hasPreviousPage
                startCursor
              }
            }
          }
        }
      )
    end

    let(:result) { EvemonkSchema.execute(query).as_json }

    specify do
      expect(result).to eq("data" => {
        "faction" => {
          "id" => "123",
          "corporationId" => 1_111,
          "corporation" => {
            "id" => "1111"
          },
          "description" => {
            "en" => "EN: description 1",
            "de" => "DE: description 1",
            "fr" => "FR: description 1",
            "ja" => "JA: description 1",
            "ru" => "RU: description 1",
            "zh" => "ZH: description 1",
            "ko" => "KO: description 1"
          },
          "isUnique" => true,
          "name" => {
            "en" => "EN: name 1",
            "de" => "DE: name 1",
            "fr" => "FR: name 1",
            "ja" => "JA: name 1",
            "ru" => "RU: name 1",
            "zh" => "ZH: name 1",
            "ko" => "KO: name 1"
          },
          "militiaCorporationId" => 2_111,
          "militiaCorporation" => {
            "id" => "2111"
          },
          "sizeFactor" => 1.5,
          "solarSystemId" => 10_111,
          "solarSystem" => {
            "id" => "10111"
          },
          "stationCount" => 100,
          "stationSystemCount" => 1_000,
          "alliances" => {
            "edges" => [
              {
                "node" => {
                  "id" => "12345"
                },
                "cursor" => "MQ"
              }
            ],
            "pageInfo" => {
              "endCursor" => "MQ",
              "hasNextPage" => false,
              "hasPreviousPage" => false,
              "startCursor" => "MQ"
            }
          }
        }
      })
    end
  end
end
