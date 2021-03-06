# frozen_string_literal: true

module Universe
  class TypesController < ApplicationController
    skip_before_action :authenticate_user!

    def show
      @type = Eve::Type
        .includes(:group,
          type_dogma_attributes: :dogma_attribute,
          market_group: {parent_group: {parent_group: :parent_group}})
        .find_by!(type_id: params[:id])
        .decorate
    end
  end
end
