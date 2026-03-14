class FermiEvaluator
  class EvaluationError < StandardError; end

  def initialize(attempt)
    @attempt = attempt
    @question = attempt.fermi_question
  end

  def evaluate!
    response = call_openai
    parsed = parse_response(response)
    update_attempt(parsed)
    @attempt
  rescue JSON::ParserError => e
    Rails.logger.error("FermiEvaluator JSON parse error: #{e.message}")
    Rails.logger.error("Raw response: #{response}")
    raise EvaluationError, "AI採点結果の解析に失敗しました。再試行してください。"
  rescue => e
    Rails.logger.error("FermiEvaluator error: #{e.class} - #{e.message}")
    raise EvaluationError, "採点中にエラーが発生しました: #{e.message}"
  end

  private

  def call_openai
    client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
    model = ENV.fetch("OPENAI_MODEL", "gpt-4o-mini")

    response = client.chat(
      parameters: {
        model: model,
        messages: [
          { role: "system", content: system_prompt },
          { role: "user", content: user_prompt }
        ],
        temperature: 0.3,
        max_tokens: 2000
      }
    )

    content = response.dig("choices", 0, "message", "content")
    raise EvaluationError, "OpenAI APIからの応答が空です" if content.blank?
    content
  end

  def system_prompt
    <<~PROMPT
      あなたはフェルミ推定の専門コーチです。
      ユーザーの回答を採点し、思考プロセスの質を評価してください。

      重要な採点方針:
      - 数値が参考レンジから多少ずれていても、思考プロセスが良ければ高評価しうる
      - 数値だけ合っていても、プロセスが弱ければ高評価しない
      - 「なぜその前提を置いたか」が弱ければ指摘する
      - 回答が短すぎる場合は、その旨を明示する
      - 厳しすぎず甘すぎず、訓練として納得感のある講評にする

      4項目の定義:
      1. decomposition_score: 因数分解の自然さ、構造化、分解の切り口の適切さ
      2. assumptions_score: 前提の明示、妥当性、飛躍の少なさ
      3. numeracy_score: 桁感、概算力、数値の整合性
      4. communication_score: 結論の明確さ、説明の簡潔さ、読みやすさ

      必ず以下のJSON形式のみで応答してください。JSON以外のテキストは一切含めないでください。
      {
        "overall_score": 0-100の整数,
        "decomposition_score": 0-100の整数,
        "assumptions_score": 0-100の整数,
        "numeracy_score": 0-100の整数,
        "communication_score": 0-100の整数,
        "strengths": ["良かった点1", "良かった点2"],
        "weaknesses": ["改善点1", "改善点2"],
        "feedback": "全体的な講評テキスト",
        "ideal_approach_summary": "模範的なアプローチの要約",
        "next_action": "次に取り組むべきこと",
        "recommended_category": "次に練習すべきカテゴリ名"
      }
    PROMPT
  end

  def user_prompt
    <<~PROMPT
      【問題情報】
      タイトル: #{@question.title}
      カテゴリ: #{@question.category}
      難易度: #{@question.difficulty}
      問題文: #{@question.prompt_text}

      【参考レンジ】
      #{@question.reference_estimate_text}

      【模範アプローチ】
      #{@question.ideal_approach_text}

      【採点観点メモ】
      #{@question.evaluation_rubric}

      【ユーザーの回答】
      推定値: #{@attempt.estimated_value_text.presence || '（未入力）'}
      思考プロセス:
      #{@attempt.reasoning_text}
    PROMPT
  end

  def parse_response(raw)
    cleaned = raw.strip
    cleaned = cleaned.gsub(/\A```json\s*/, "").gsub(/\s*```\z/, "")
    JSON.parse(cleaned)
  end

  def update_attempt(data)
    @attempt.update!(
      status: "evaluated",
      overall_score: data["overall_score"],
      decomposition_score: data["decomposition_score"],
      assumptions_score: data["assumptions_score"],
      numeracy_score: data["numeracy_score"],
      communication_score: data["communication_score"],
      strengths_text: Array(data["strengths"]).join("\n"),
      weaknesses_text: Array(data["weaknesses"]).join("\n"),
      feedback_text: data["feedback"],
      ideal_approach_summary_text: data["ideal_approach_summary"],
      next_action_text: data["next_action"],
      recommended_fermi_question_id: find_recommended_question(data["recommended_category"])&.id
    )
  end

  def find_recommended_question(category)
    FermiRecommendationService.new(@attempt.user, category).recommend
  end
end
