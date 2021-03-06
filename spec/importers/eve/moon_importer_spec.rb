# frozen_string_literal: true

require "rails_helper"

describe Eve::MoonImporter do
  describe "#import" do
    context "when fresh data available" do
      context "when moon found" do
        let(:planet_id) { double }

        let(:moon_id) { double }

        subject { described_class.new(planet_id, moon_id) }

        let(:eve_moon) { instance_double(Eve::Moon) }

        before { expect(Eve::Moon).to receive(:find_or_initialize_by).with(planet_id: planet_id, moon_id: moon_id).and_return(eve_moon) }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:response) { double }

        let(:position_json) { double }

        let(:position) do
          instance_double(EveOnline::ESI::Models::Position,
            as_json: position_json)
        end

        let(:esi) do
          instance_double(EveOnline::ESI::UniverseMoon,
            url: url,
            not_modified?: false,
            etag: new_etag,
            as_json: json,
            position: position,
            response: response)
        end

        before { expect(EveOnline::ESI::UniverseMoon).to receive(:new).with(id: moon_id).and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

        before { expect(eve_moon).to receive(:update!).with(json) }

        before do
          #
          # eve_moon.position&.destroy
          #
          expect(eve_moon).to receive(:position) do
            double.tap do |a|
              expect(a).to receive(:destroy)
            end
          end
        end

        before do
          #
          # eve_moon.create_position!(esi.position.as_json)
          #
          expect(eve_moon).to receive(:create_position!).with(position_json)
        end

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when moon not found" do
        let(:planet_id) { double }

        let(:moon_id) { double }

        subject { described_class.new(planet_id, moon_id) }

        let(:eve_moon) { instance_double(Eve::Moon) }

        before { expect(Eve::Moon).to receive(:find_or_initialize_by).with(planet_id: planet_id, moon_id: moon_id).and_return(eve_moon) }

        before { expect(EveOnline::ESI::UniverseMoon).to receive(:new).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_moon).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:planet_id) { double }

      let(:moon_id) { double }

      subject { described_class.new(planet_id, moon_id) }

      let(:eve_moon) { instance_double(Eve::Moon) }

      before { expect(Eve::Moon).to receive(:find_or_initialize_by).with(planet_id: planet_id, moon_id: moon_id).and_return(eve_moon) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::UniverseMoon,
          url: url,
          not_modified?: true)
      end

      before { expect(EveOnline::ESI::UniverseMoon).to receive(:new).with(id: moon_id).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("68ad4a11893776c0ffc80845edeb2687c0122f56287d2aecadf8739b") }

      before { expect(eve_moon).not_to receive(:update!) }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
