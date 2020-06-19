# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_19_161730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attempt_answers", force: :cascade do |t|
    t.string "answer", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "question_id", null: false
    t.bigint "attempt_id", null: false
    t.index ["attempt_id"], name: "index_attempt_answers_on_attempt_id"
    t.index ["question_id", "attempt_id"], name: "index_attempt_answers_on_question_id_and_attempt_id", unique: true
    t.index ["question_id"], name: "index_attempt_answers_on_question_id"
  end

  create_table "attempts", force: :cascade do |t|
    t.boolean "submitted", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "quiz_id", null: false
    t.integer "correct_answers_count", default: 0, null: false
    t.integer "incorrect_answers_count", default: 0, null: false
    t.index ["quiz_id"], name: "index_attempts_on_quiz_id"
    t.index ["user_id", "quiz_id"], name: "index_attempts_on_user_id_and_quiz_id", unique: true
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "question_multiple_choices", force: :cascade do |t|
    t.jsonb "options", default: [], null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "question_id", null: false
    t.index ["question_id"], name: "index_question_multiple_choices_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "quiz_id", null: false
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.string "slug"
    t.index ["slug"], name: "index_quizzes_on_slug", unique: true
    t.index ["user_id"], name: "index_quizzes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "attempt_answers", "attempts", on_delete: :cascade
  add_foreign_key "attempt_answers", "questions", on_delete: :cascade
  add_foreign_key "attempts", "quizzes", on_delete: :cascade
  add_foreign_key "attempts", "users", on_delete: :restrict
  add_foreign_key "question_multiple_choices", "questions", on_delete: :cascade
  add_foreign_key "questions", "quizzes", on_delete: :cascade
  add_foreign_key "quizzes", "users", on_delete: :restrict
end
