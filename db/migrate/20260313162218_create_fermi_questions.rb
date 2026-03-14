class CreateFermiQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :fermi_questions do |t|
      t.string :title
      t.string :slug
      t.text :prompt_text
      t.string :category
      t.string :difficulty
      t.integer :estimated_minutes
      t.text :reference_estimate_text
      t.text :ideal_approach_text
      t.text :evaluation_rubric

      t.timestamps
    end
  end
end
