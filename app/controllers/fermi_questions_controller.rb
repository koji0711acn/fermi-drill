class FermiQuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = FermiQuestion.all
    @questions = @questions.by_category(params[:category]) if params[:category].present?
    @questions = @questions.by_difficulty(params[:difficulty]) if params[:difficulty].present?
    @questions = @questions.order(:difficulty, :title)
  end

  def show
    @question = FermiQuestion.find(params[:id])
    @user_attempts = current_user.fermi_attempts.where(fermi_question: @question).recent
  end
end
