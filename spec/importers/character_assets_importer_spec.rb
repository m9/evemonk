# frozen_string_literal: true

require "rails_helper"

describe CharacterAssetsImporter do
  let(:character_id) { double }

  let(:page) { double }

  subject { described_class.new(character_id, page) }

  it { should be_a(CharacterBaseImporter) }

  describe "#initialize" do
    context "when page not present" do
      subject { described_class.new(character_id) }

      its(:character_id) { should eq(character_id) }

      its(:page) { should eq(1) }
    end

    context "when page is present" do
      its(:character_id) { should eq(character_id) }

      its(:page) { should eq(page) }
    end
  end

  describe "#update!" do
    context "when scope present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "esi-assets.read_assets.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(4).times }

      let(:json) { double }

      let(:asset) { instance_double(EveOnline::ESI::Models::Asset, as_json: json) }

      let(:total_pages) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterAssets,
          assets: [asset],
          scope: "esi-assets.read_assets.v1",
          total_pages: total_pages)
      end

      before { expect(EveOnline::ESI::CharacterAssets).to receive(:new).with(character_id: character_id, token: access_token, page: page).and_return(esi) }

      before { expect(subject).to receive(:destroy_old_character_assets).with(page) }

      before do
        #
        # character.character_assets.create!(asset.as_json)
        #
        expect(character).to receive(:character_assets) do
          double.tap do |a|
            expect(a).to receive(:create!).with(json)
          end
        end
      end

      before { expect(subject).to receive(:import_other_pages).with(total_pages) }

      specify { expect { subject.update! }.not_to raise_error }
    end

    context "when scope not present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(3).times }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterAssets,
          scope: "esi-assets.read_assets.v1")
      end

      before { expect(EveOnline::ESI::CharacterAssets).to receive(:new).with(character_id: character_id, token: access_token, page: page).and_return(esi) }

      before { expect(character).not_to receive(:character_assets) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end

  # private methods

  describe "#destroy_old_character_assets" do
    context "when page is first" do
      let(:page) { 1 }

      before do
        #
        # character.character_assets.destroy_all
        #
        expect(subject).to receive(:character) do
          double.tap do |a|
            expect(a).to receive(:character_assets) do
              double.tap do |b|
                expect(b).to receive(:destroy_all)
              end
            end
          end
        end
      end

      specify { expect { subject.send(:destroy_old_character_assets, page) }.not_to raise_error }
    end

    context "when page is not first" do
      let(:page) { 2 }

      before { expect(subject).not_to receive(:character) }

      specify { expect { subject.send(:destroy_old_character_assets, page) }.not_to raise_error }
    end
  end

  describe "#import_other_pages" do
    context "when page is more than 1" do
      let(:page) { 2 }

      let(:total_pages) { 2 }

      before { expect(CharacterAssetsJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages, total_pages) }.not_to raise_error }
    end

    context "when total pages is 1" do
      let(:page) { 1 }

      let(:total_pages) { 1 }

      before { expect(CharacterAssetsJob).not_to receive(:perform_later) }

      specify { expect { subject.send(:import_other_pages, total_pages) }.not_to raise_error }
    end

    context "when page is 1 and total pages more than 1" do
      let(:page) { 1 }

      let(:total_pages) { 2 }

      before { expect(CharacterAssetsJob).to receive(:perform_later).with(character_id, 2) }

      specify { expect { subject.send(:import_other_pages, total_pages) }.not_to raise_error }
    end
  end
end
