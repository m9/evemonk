module Api
  class SessionsController < BaseController
    private

    def resource
      @session ||= Session.find(params[:id])
    end

    def collection
      @sessions ||= Session.order(created_at: :asc)
                           .page(params[:page])
    end
  end
end
