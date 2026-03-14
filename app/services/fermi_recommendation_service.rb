class FermiRecommendationService
  def initialize(user, preferred_category = nil)
    @user = user
    @preferred_category = preferred_category
  end

  def recommend
    attempted_ids = @user.fermi_attempts.pluck(:fermi_question_id)

    # 1. Try preferred category first (unanswered)
    if @preferred_category.present?
      q = FermiQuestion.where(category: @preferred_category)
                       .where.not(id: attempted_ids)
                       .order("RANDOM()")
                       .first
      return q if q
    end

    # 2. Try same difficulty as last attempt
    last_attempt = @user.fermi_attempts.recent.first
    if last_attempt
      q = FermiQuestion.where(difficulty: last_attempt.fermi_question.difficulty)
                       .where.not(id: attempted_ids)
                       .order("RANDOM()")
                       .first
      return q if q
    end

    # 3. Any unanswered question
    q = FermiQuestion.where.not(id: attempted_ids)
                     .order("RANDOM()")
                     .first
    return q if q

    # 4. If all answered, return random
    FermiQuestion.order("RANDOM()").first
  end

  def today_question
    today_attempts = @user.fermi_attempts.where("created_at >= ?", Time.current.beginning_of_day)
    if today_attempts.empty?
      recommend
    else
      nil
    end
  end
end
