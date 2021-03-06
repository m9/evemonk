# frozen_string_literal: true

module Eve
  class BlueprintManufacturingMaterialDecorator < ApplicationDecorator
    decorates_associations :blueprint, :type
  end
end
