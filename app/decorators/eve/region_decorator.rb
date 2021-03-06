# frozen_string_literal: true

module Eve
  class RegionDecorator < ApplicationDecorator
    decorates_associations :constellations, :contracts
  end
end
