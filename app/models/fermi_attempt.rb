class FermiAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :fermi_question
  belongs_to :recommended_fermi_question, class_name: "FermiQuestion", optional: true

  STATUSES = %w[submitted evaluating evaluated].freeze

  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :reasoning_text, presence: true

  scope :evaluated, -> { where(status: "evaluated") }
  scope :recent, -> { order(created_at: :desc) }

  def evaluated?
    status == "evaluated"
  end

  def evaluating?
    status == "evaluating"
  end

  def score_breakdown
    {
      decomposition: decomposition_score,
      assumptions: assumptions_score,
      numeracy: numeracy_score,
      communication: communication_score
    }
  end

  def weakest_area
    return nil unless evaluated?
    score_breakdown.min_by { |_, v| v || 100 }&.first
  end
end
