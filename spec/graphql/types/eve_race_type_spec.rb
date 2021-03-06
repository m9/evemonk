# frozen_string_literal: true

require "rails_helper"

describe Types::EveRaceType do
  describe "get races" do
    let!(:eve_faction1) do
      create(:eve_faction,
        faction_id: 1_000_111)
    end

    let!(:eve_faction2) do
      create(:eve_faction,
        faction_id: 1_000_222)
    end

    let!(:eve_bloodline1) do
      create(:eve_bloodline,
        bloodline_id: 10,
        race: eve_race1)
    end

    let!(:eve_bloodline2) do
      create(:eve_bloodline,
        bloodline_id: 20,
        race: eve_race2)
    end

    let!(:eve_station1) do
      create(:eve_station,
        station_id: 100,
        race: eve_race1)
    end

    let!(:eve_station2) do
      create(:eve_station,
        station_id: 200,
        race: eve_race2)
    end

    let!(:eve_race1) do
      create(:eve_race,
        race_id: 4,
        name_en: "EN: name 1",
        name_de: "DE: name 1",
        name_fr: "FR: name 1",
        name_ja: "JA: name 1",
        name_ru: "RU: name 1",
        name_zh: "ZH: name 1",
        name_ko: "KO: name 1",
        description_en: "EN: description 1",
        description_de: "DE: description 1",
        description_fr: "FR: description 1",
        description_ja: "JA: description 1",
        description_ru: "RU: description 1",
        description_zh: "ZH: description 1",
        description_ko: "KO: description 1",
        faction: eve_faction1)
    end

    let!(:eve_race2) do
      create(:eve_race,
        race_id: 8,
        name_en: "EN: name 2",
        name_de: "DE: name 2",
        name_fr: "FR: name 2",
        name_ja: "JA: name 2",
        name_ru: "RU: name 2",
        name_zh: "ZH: name 2",
        name_ko: "KO: name 2",
        description_en: "EN: description 2",
        description_de: "DE: description 2",
        description_fr: "FR: description 2",
        description_ja: "JA: description 2",
        description_ru: "RU: description 2",
        description_zh: "ZH: description 2",
        description_ko: "KO: description 2",
        faction: eve_faction2)
    end

    let(:query) do
      %(
        {
          races(first: 2) {
            edges {
              node {
                id
                name
                description
                factionId
                faction {
                  id
                }
                bloodlines(first: 1) {
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
                stations(first: 1) {
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
        "races" => {
          "edges" => [
            {
              "node" => {
                "id" => "4",
                "name" => {
                  "en" => "EN: name 1",
                  "de" => "DE: name 1",
                  "fr" => "FR: name 1",
                  "ja" => "JA: name 1",
                  "ru" => "RU: name 1",
                  "zh" => "ZH: name 1",
                  "ko" => "KO: name 1"
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
                "factionId" => 1_000_111,
                "faction" => {
                  "id" => "1000111"
                },
                "bloodlines" => {
                  "edges" => [
                    {
                      "node" => {
                        "id" => "10"
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
                },
                "stations" => {
                  "edges" => [
                    {
                      "node" => {
                        "id" => "100"
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
                "id" => "8",
                "name" => {
                  "en" => "EN: name 2",
                  "de" => "DE: name 2",
                  "fr" => "FR: name 2",
                  "ja" => "JA: name 2",
                  "ru" => "RU: name 2",
                  "zh" => "ZH: name 2",
                  "ko" => "KO: name 2"
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
                "factionId" => 1_000_222,
                "faction" => {
                  "id" => "1000222"
                },
                "bloodlines" => {
                  "edges" => [
                    {
                      "node" => {
                        "id" => "20"
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
                },
                "stations" => {
                  "edges" => [
                    {
                      "node" => {
                        "id" => "200"
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

  describe "get race by id" do
    let!(:eve_faction) do
      create(:eve_faction,
        faction_id: 1_000_111)
    end

    let!(:eve_bloodline) do
      create(:eve_bloodline,
        bloodline_id: 10,
        race: eve_race)
    end

    let!(:eve_station) do
      create(:eve_station,
        station_id: 100,
        race: eve_race)
    end

    let!(:eve_race) do
      create(:eve_race,
        race_id: 4,
        name_en: "EN: name 1",
        name_de: "DE: name 1",
        name_fr: "FR: name 1",
        name_ja: "JA: name 1",
        name_ru: "RU: name 1",
        name_zh: "ZH: name 1",
        name_ko: "KO: name 1",
        description_en: "EN: description 1",
        description_de: "DE: description 1",
        description_fr: "FR: description 1",
        description_ja: "JA: description 1",
        description_ru: "RU: description 1",
        description_zh: "ZH: description 1",
        description_ko: "KO: description 1",
        faction: eve_faction)
    end

    let(:query) do
      %(
        {
          race(id: 4) {
            id
            name
            description
            factionId
            faction {
              id
            }
            bloodlines(first: 1) {
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
            stations(first: 1) {
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
        "race" => {
          "id" => "4",
          "name" => {
            "en" => "EN: name 1",
            "de" => "DE: name 1",
            "fr" => "FR: name 1",
            "ja" => "JA: name 1",
            "ru" => "RU: name 1",
            "zh" => "ZH: name 1",
            "ko" => "KO: name 1"
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
          "factionId" => 1_000_111,
          "faction" => {
            "id" => "1000111"
          },
          "bloodlines" => {
            "edges" => [
              {
                "node" => {
                  "id" => "10"
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
          },
          "stations" => {
            "edges" => [
              {
                "node" => {
                  "id" => "100"
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
