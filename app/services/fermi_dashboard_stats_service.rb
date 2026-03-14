class FermiDashboardStatsService
  def initialize(user)
    @user = user
    @attempts = user.fermi_attempts.evaluated
  end

  def stats
    {
      total_count: total_count,
      average_score: average_score,
      recent_average_score: recent_average_score,
      weakest_area: weakest_area,
      top_categories: top_categories,
      last_practiced_at: last_practiced_at,
      recent_attempts: recent_attempts,
      score_history: score_history,
      skill_radar: skill_radar
    }
  end

  private

  def total_count
    @attempts.count
  end

  def average_score
    return nil if @attempts.empty?
    @attempts.average(:overall_score)&.round(1)
  end

  def recent_average_score
    recent = @attempts.recent.limit(5)
    return nil if recent.empty?
    recent.average(:overall_score)&.round(1)
  end

  def weakest_area
    recent = @attempts.recent.limit(5)
    return nil if recent.empty?

    averages = {
      "因数分解" => recent.average(:decomposition_score)&.to_f || 0,
      "前提設定" => recent.average(:assumptions_score)&.to_f || 0,
      "桁感" => recent.average(:numeracy_score)&.to_f || 0,
      "伝達力" => recent.average(:communication_score)&.to_f || 0
    }

    weakest = averages.min_by { |_, v| v }
    { name: weakest[0], score: weakest[1].round(1) }
  end

  def top_categories
    @user.fermi_attempts
         .joins(:fermi_question)
         .group("fermi_questions.category")
         .order("count_all DESC")
         .limit(3)
         .count
  end

  def last_practiced_at
    @user.fermi_attempts.recent.first&.created_at
  end

  def recent_attempts
    @user.fermi_attempts.recent.includes(:fermi_question).limit(5)
  end

  # Chart data: last 20 evaluated attempts
  def score_history
    records = @attempts.recent.limit(20).to_a.reverse
    return nil if records.size < 2

    {
      labels: records.map { |a| a.created_at.strftime("%m/%d") },
      overall: records.map(&:overall_score),
      decomposition: records.map(&:decomposition_score),
      assumptions: records.map(&:assumptions_score),
      numeracy: records.map(&:numeracy_score),
      communication: records.map(&:communication_score)
    }
  end

  # Radar chart: average of last 10 for each skill
  def skill_radar
    recent = @attempts.recent.limit(10)
    return nil if recent.empty?

    {
      labels: ["因数分解", "前提設定", "桁感", "伝達力"],
      values: [
        recent.average(:decomposition_score)&.to_f&.round(1) || 0,
        recent.average(:assumptions_score)&.to_f&.round(1) || 0,
        recent.average(:numeracy_score)&.to_f&.round(1) || 0,
        recent.average(:communication_score)&.to_f&.round(1) || 0
      ]
    }
  end
end
