class WeaknessDrillService
  SKILL_MAP = {
    "decomposition" => { name: "因数分解", column: :decomposition_score },
    "assumptions" => { name: "前提設定", column: :assumptions_score },
    "numeracy" => { name: "桁感", column: :numeracy_score },
    "communication" => { name: "伝達力", column: :communication_score }
  }.freeze

  def initialize(user)
    @user = user
    @evaluated = user.fermi_attempts.evaluated
  end

  def analysis
    return nil if @evaluated.count < 3

    recent = @evaluated.recent.limit(10)

    skills = SKILL_MAP.map do |key, info|
      avg = recent.average(info[:column])&.to_f&.round(1) || 0
      { key: key, name: info[:name], average: avg }
    end

    weakest_skill = skills.min_by { |s| s[:average] }

    # Find categories where user scored lowest
    weak_categories = find_weak_categories(recent)

    {
      skills: skills.sort_by { |s| s[:average] },
      weakest_skill: weakest_skill,
      weak_categories: weak_categories,
      recommended_questions: recommended_questions(weak_categories, weakest_skill)
    }
  end

  def recommended_questions(weak_categories = nil, weakest_skill = nil)
    data = analysis_data
    weak_categories ||= data[:weak_categories] if data
    weakest_skill ||= data[:weakest_skill] if data

    attempted_ids = @user.fermi_attempts.pluck(:fermi_question_id)
    questions = []

    # Priority 1: Questions from weak categories (unanswered)
    if weak_categories&.any?
      weak_categories.each do |cat_info|
        q = FermiQuestion.where(category: cat_info[:category])
                         .where.not(id: attempted_ids + questions.map(&:id))
                         .order("RANDOM()")
                         .first
        questions << q if q
        break if questions.size >= 3
      end
    end

    # Priority 2: Fill remaining slots with random unanswered
    if questions.size < 3
      remaining = FermiQuestion.where.not(id: attempted_ids + questions.map(&:id))
                               .order("RANDOM()")
                               .limit(3 - questions.size)
      questions += remaining.to_a
    end

    questions
  end

  private

  def analysis_data
    @_analysis_data ||= analysis
  end

  def find_weak_categories(recent)
    category_scores = {}

    recent.includes(:fermi_question).each do |attempt|
      cat = attempt.fermi_question.category
      category_scores[cat] ||= []
      category_scores[cat] << attempt.overall_score
    end

    category_scores.map do |cat, scores|
      { category: cat, average: (scores.sum.to_f / scores.size).round(1), count: scores.size }
    end.select { |c| c[:count] >= 1 }
      .sort_by { |c| c[:average] }
      .first(3)
  end
end
