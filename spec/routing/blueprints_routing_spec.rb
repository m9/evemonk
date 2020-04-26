# frozen_string_literal: true

require "rails_helper"

describe BlueprintsController do
  describe "routing" do
    it "should route GET /characters/90729314/blueprints to blueprints#index" do
      expect(get: "/characters/90729314/blueprints").to route_to(
        controller: "blueprints",
        action: "index",
        character_id: "90729314"
      )
    end

    it "should route GET /characters/90729314/blueprints/716338097 to blueprints#show" do
      expect(get: "/characters/90729314/blueprints/716338097").to route_to(
        controller: "blueprints",
        action: "show",
        character_id: "90729314",
        id: "716338097"
      )
    end
  end
end
