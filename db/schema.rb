# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_13_162230) do
  create_table "fermi_attempts", force: :cascade do |t|
    t.integer "assumptions_score"
    t.integer "communication_score"
    t.datetime "created_at", null: false
    t.integer "decomposition_score"
    t.string "estimated_value_text"
    t.text "feedback_text"
    t.integer "fermi_question_id", null: false
    t.text "ideal_approach_summary_text"
    t.text "next_action_text"
    t.integer "numeracy_score"
    t.integer "overall_score"
    t.text "reasoning_text"
    t.integer "recommended_fermi_question_id"
    t.string "status"
    t.text "strengths_text"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.text "weaknesses_text"
    t.index ["fermi_question_id"], name: "index_fermi_attempts_on_fermi_question_id"
    t.index ["recommended_fermi_question_id"], name: "index_fermi_attempts_on_recommended_fermi_question_id"
    t.index ["user_id"], name: "index_fermi_attempts_on_user_id"
  end

  create_table "fermi_questions", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.string "difficulty"
    t.integer "estimated_minutes"
    t.text "evaluation_rubric"
    t.text "ideal_approach_text"
    t.text "prompt_text"
    t.text "reference_estimate_text"
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "fermi_attempts", "fermi_questions"
  add_foreign_key "fermi_attempts", "fermi_questions", column: "recommended_fermi_question_id"
  add_foreign_key "fermi_attempts", "users"
end
