# frozen_string_literal: true

class AgentsController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation, :agents_standings)
      .find_by!(character_id: params[:character_id])
      .decorate
  end
end
