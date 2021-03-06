# frozen_string_literal: true

require "rails_helper"

describe CharacterShowReflex do
  subject { described_class.new(double) }

  it { should be_an(ApplicationReflex) }

  describe "#update" do
    let(:character_id) { "1337512245" }

    let(:data) do
      {
        "dataset" => {
          "id" => "1337512245"
        }
      }
    end

    let(:element) { StimulusReflex::Element.new(data) }

    subject { described_class.new(double, element: element) }

    before do
      #
      # CharacterImporter.new(character_id).import
      #
      expect(CharacterImporter).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # CharacterSkillsImporter.new(character_id).import
      #
      expect(CharacterSkillsImporter).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # CharacterWalletImporter.new(character_id).import
      #
      expect(CharacterWalletImporter).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # CharacterLocationImporter.new(character_id).import
      #
      expect(CharacterLocationImporter).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # CharacterShipImporter.new(character_id).import
      #
      expect(CharacterShipImporter).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # CharacterAttributesImporter.new(character_id).import
      #
      expect(CharacterAttributesImporter).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    before do
      #
      # CharacterImplantsImporter.new(character_id).import
      #
      expect(CharacterImplantsImporter).to receive(:new).with(character_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.update }.not_to raise_error }
  end
end
