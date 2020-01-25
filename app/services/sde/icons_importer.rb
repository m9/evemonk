# frozen_string_literal: true

module Sde
  class IconsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load(File.read(file))

      entries.each_pair do |key, hash|
        icon = Eve::Icon.find_or_initialize_by(icon_id: key)

        icon.assign_attributes(description: hash["description"],
                               icon_file: hash["iconFile"],
                               obsolete: hash["obsolete"],
                               backgrounds: hash["backgrounds"],
                               foregrounds: hash["foregrounds"])

        icon.save!
      end
    end
  end
end
