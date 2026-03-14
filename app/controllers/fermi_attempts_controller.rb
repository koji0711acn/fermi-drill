class FermiAttemptsController < ApplicationController
  before_action :authenticate_user!

  def index
    @attempts = current_user.fermi_attempts.includes(:fermi_question).recent
  end

  def show
    @attempt = current_user.fermi_attempts.includes(:fermi_question, :recommended_fermi_question).find(params[:id])
  end

  def new
    @question = FermiQuestion.find(params[:fermi_question_id])
    @attempt = FermiAttempt.new
  end

  def create
    @question = FermiQuestion.find(params[:fermi_question_id])
    @attempt = current_user.fermi_attempts.build(attempt_params)
    @attempt.fermi_question = @question
    @attempt.status = "evaluating"

    if @attempt.save
      FermiEvaluationJob.perform_later(@attempt.id)
      redirect_to fermi_attempt_path(@attempt), notice: "回答を提出しました。AI採点中です..."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def retry_evaluation
    @attempt = current_user.fermi_attempts.find(params[:id])

    if @attempt.evaluated?
      redirect_to fermi_attempt_path(@attempt), notice: "既に採点済みです。"
    else
      @attempt.update!(status: "evaluating")
      FermiEvaluationJob.perform_later(@attempt.id)
      redirect_to fermi_attempt_path(@attempt), notice: "再採点をリクエストしました..."
    end
  end

  def status
    @attempt = current_user.fermi_attempts.find(params[:id])
    render json: { status: @attempt.status, evaluated: @attempt.evaluated? }
  end

  private

  def attempt_params
    params.require(:fermi_attempt).permit(:estimated_value_text, :reasoning_text)
  end
end
