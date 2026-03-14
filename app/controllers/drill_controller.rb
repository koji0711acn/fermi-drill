class DrillController < ApplicationController
  before_action :authenticate_user!

  def weakness
    service = WeaknessDrillService.new(current_user)
    @analysis = service.analysis
    @questions = service.recommended_questions
  end
end
