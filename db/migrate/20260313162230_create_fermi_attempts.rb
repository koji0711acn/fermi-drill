class CreateFermiAttempts < ActiveRecord::Migration[8.1]
  def change
    create_table :fermi_attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :fermi_question, null: false, foreign_key: true
      t.string :estimated_value_text
      t.text :reasoning_text
      t.string :status
      t.integer :overall_score
      t.integer :decomposition_score
      t.integer :assumptions_score
      t.integer :numeracy_score
      t.integer :communication_score
      t.text :strengths_text
      t.text :weaknesses_text
      t.text :feedback_text
      t.text :ideal_approach_summary_text
      t.text :next_action_text
      t.references :recommended_fermi_question, null: true, foreign_key: { to_table: :fermi_questions }

      t.timestamps
    end
  end
end
