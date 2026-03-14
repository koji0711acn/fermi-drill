class FermiEvaluationJob < ApplicationJob
  queue_as :default
  retry_on FermiEvaluator::EvaluationError, wait: 5.seconds, attempts: 3

  discard_on ActiveRecord::RecordNotFound

  def perform(attempt_id)
    attempt = FermiAttempt.find(attempt_id)
    return if attempt.evaluated?

    FermiEvaluator.new(attempt).evaluate!
  rescue FermiEvaluator::EvaluationError => e
    attempt = FermiAttempt.find_by(id: attempt_id)
    if attempt && attempts_remaining?
      Rails.logger.error("FermiEvaluationJob retrying for attempt ##{attempt_id}: #{e.message}")
      raise
    else
      Rails.logger.error("FermiEvaluationJob giving up for attempt ##{attempt_id}: #{e.message}")
      attempt&.update(status: "submitted")
    end
  end

  private

  def attempts_remaining?
    executions < 3
  end
end
