# frozen_string_literal: true

require "rails_helper"

describe CharacterBlueprintDecorator do
  subject { described_class.new(double) }

  it { should be_an(ApplicationDecorator) }

  it { should be_a(LocationableDecorator) }

  describe "#bpo?" do
    context "when blueprint is original" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -1) }

      subject { character_blueprint.decorate }

      specify { expect(subject.bpo?).to eq(true) }
    end

    context "when blueprint is copy" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -2) }

      subject { character_blueprint.decorate }

      specify { expect(subject.bpo?).to eq(false) }
    end
  end

  describe "#bpc?" do
    context "when blueprint is original" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -1) }

      subject { character_blueprint.decorate }

      specify { expect(subject.bpc?).to eq(false) }
    end

    context "when blueprint is copy" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -2) }

      subject { character_blueprint.decorate }

      specify { expect(subject.bpc?).to eq(true) }
    end
  end

  describe "#stacked?" do
    context "when stacked" do
      let(:character_blueprint) { build(:character_blueprint, quantity: 10) }

      subject { character_blueprint.decorate }

      specify { expect(subject.stacked?).to eq(true) }
    end

    context "when not stacked" do
      let(:character_blueprint) { build(:character_blueprint, quantity: -1) }

      subject { character_blueprint.decorate }

      specify { expect(subject.stacked?).to eq(false) }
    end
  end

  describe "#icon_tiny" do
    context "when stacked" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: 10,
          type_id: 804)
      end

      subject { character_blueprint.decorate }

      context "when Setting.use_image_proxy is true" do
        before { Setting.use_image_proxy = true }

        specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/804/bp?size=32") }
      end

      context "when Setting.use_image_proxy is false" do
        before { Setting.use_image_proxy = false }

        specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/types/804/bp?size=32") }
      end
    end

    context "when blueprint is original" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804)
      end

      subject { character_blueprint.decorate }

      context "when Setting.use_image_proxy is true" do
        before { Setting.use_image_proxy = true }

        specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/804/bp?size=32") }
      end

      context "when Setting.use_image_proxy is false" do
        before { Setting.use_image_proxy = false }

        specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/types/804/bp?size=32") }
      end
    end

    context "when blueprint is copy" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: -2,
          type_id: 804)
      end

      subject { character_blueprint.decorate }

      context "when Setting.use_image_proxy is true" do
        before { Setting.use_image_proxy = true }

        specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/804/bpc?size=32") }
      end

      context "when Setting.use_image_proxy is false" do
        before { Setting.use_image_proxy = false }

        specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/types/804/bpc?size=32") }
      end
    end
  end

  describe "#icon_small" do
    context "when stacked" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: 10,
          type_id: 804)
      end

      subject { character_blueprint.decorate }

      context "when Setting.use_image_proxy is true" do
        before { Setting.use_image_proxy = true }

        specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/804/bp?size=64") }
      end

      context "when Setting.use_image_proxy is false" do
        before { Setting.use_image_proxy = false }

        specify { expect(subject.icon_small).to eq("https://images.evetech.net/types/804/bp?size=64") }
      end
    end

    context "when blueprint is original" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804)
      end

      subject { character_blueprint.decorate }

      context "when Setting.use_image_proxy is true" do
        before { Setting.use_image_proxy = true }

        specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/804/bp?size=64") }
      end

      context "when Setting.use_image_proxy is false" do
        before { Setting.use_image_proxy = false }

        specify { expect(subject.icon_small).to eq("https://images.evetech.net/types/804/bp?size=64") }
      end
    end

    context "when blueprint is copy" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: -2,
          type_id: 804)
      end

      subject { character_blueprint.decorate }

      context "when Setting.use_image_proxy is true" do
        before { Setting.use_image_proxy = true }

        specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/types/804/bpc?size=64") }
      end

      context "when Setting.use_image_proxy is false" do
        before { Setting.use_image_proxy = false }

        specify { expect(subject.icon_small).to eq("https://images.evetech.net/types/804/bpc?size=64") }
      end
    end
  end

  describe "#material_efficiency_formatted" do
    context "when stacked" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: 10,
          type_id: 804)
      end

      subject { character_blueprint.decorate }

      specify { expect(subject.material_efficiency_formatted).to eq(nil) }
    end

    context "when material efficiency is zero" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804,
          material_efficiency: 0)
      end

      subject { character_blueprint.decorate }

      specify { expect(subject.material_efficiency_formatted).to eq("0 %") }
    end

    context "when material efficiency is more than zero" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804,
          material_efficiency: 10)
      end

      subject { character_blueprint.decorate }

      specify { expect(subject.material_efficiency_formatted).to eq("+10 %") }
    end
  end

  describe "#time_efficiency_formatted" do
    context "when stacked" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: 10,
          type_id: 804)
      end

      subject { character_blueprint.decorate }

      specify { expect(subject.time_efficiency_formatted).to eq(nil) }
    end

    context "when time efficiency is zero" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804,
          time_efficiency: 0)
      end

      subject { character_blueprint.decorate }

      specify { expect(subject.time_efficiency_formatted).to eq("0 %") }
    end

    context "when time efficiency is more than zero" do
      let(:character_blueprint) do
        build(:character_blueprint,
          quantity: -1,
          type_id: 804,
          time_efficiency: 10)
      end

      subject { character_blueprint.decorate }

      specify { expect(subject.time_efficiency_formatted).to eq("+10 %") }
    end
  end
end
