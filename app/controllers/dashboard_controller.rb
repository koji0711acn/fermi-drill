class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    service = FermiDashboardStatsService.new(current_user)
    @stats = service.stats
    @today_question = FermiRecommendationService.new(current_user).today_question
  end
end
