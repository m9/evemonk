# frozen_string_literal: true

class CharacterBlueprintDecorator < ApplicationDecorator
  include LocationableDecorator

  decorates_associations :character, :blueprint, :location

  # BPO -- Blue Print Original
  def bpo?
    quantity == -1
  end

  # BPC -- Blue Print Copy
  def bpc?
    quantity == -2
  end

  def stacked?
    quantity.positive?
  end

  def icon_tiny
    if stacked? || bpo?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bp?size=32"
    elsif bpc?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bpc?size=32"
    end
  end

  def icon_small
    if stacked? || bpo?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bp?size=64"
    elsif bpc?
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/bpc?size=64"
    end
  end

  def material_efficiency_formatted
    return if stacked?

    if material_efficiency.zero?
      "#{material_efficiency} %"
    else
      "+#{material_efficiency} %"
    end
  end

  def time_efficiency_formatted
    return if stacked?

    if time_efficiency.zero?
      "#{time_efficiency} %"
    else
      "+#{time_efficiency} %"
    end
  end

  # def character_copying_time_formatted
  #   HumanTime.new(CharacterManufacturingCopyTime.new(@character, @blueprint.blueprint.copying_time).manufacturing_copy_time.round).long_formatted
  # end
end
