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

ActiveRecord::Schema[8.1].define(version: 2026_06_16_123041) do
  create_table "metric_entries", force: :cascade do |t|
    t.decimal "broad_jump_inches"
    t.integer "chin_ups"
    t.datetime "created_at", null: false
    t.decimal "fifty_yard_dash_seconds"
    t.decimal "flexibility_inches"
    t.integer "handstand_seconds"
    t.text "notes"
    t.integer "one_mile_run_seconds"
    t.integer "pull_ups"
    t.integer "push_ups"
    t.date "recorded_on"
    t.integer "rope_climb_seconds"
    t.decimal "shuttle_run_seconds"
    t.integer "sit_ups"
    t.decimal "throw_distance_inches"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.decimal "vertical_jump_inches"
    t.index ["user_id"], name: "index_metric_entries_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.datetime "updated_at", null: false
    t.string "username"
  end

  add_foreign_key "metric_entries", "users"
end
