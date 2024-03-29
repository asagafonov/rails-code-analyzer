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

ActiveRecord::Schema[7.0].define(version: 2023_03_13_112709) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "timescaledb"

  create_table "repositories", force: :cascade do |t|
    t.string "full_name"
    t.string "name"
    t.string "language"
    t.string "state"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "github_id"
    t.string "clone_url"
    t.string "default_branch"
    t.string "repo_created_at"
    t.string "repo_updated_at"
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "repository_check_linter_errors", force: :cascade do |t|
    t.string "file_path"
    t.string "message"
    t.string "rule"
    t.string "location"
    t.bigint "check_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_id"], name: "index_repository_check_linter_errors_on_check_id"
  end

  create_table "repository_checks", force: :cascade do |t|
    t.string "last_commit_sha"
    t.string "aasm_state"
    t.bigint "repository_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "linter_errors_count"
    t.string "last_commit_url"
    t.boolean "passed"
    t.index ["repository_id"], name: "index_repository_checks_on_repository_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "nickname"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "repositories", "users"
  add_foreign_key "repository_check_linter_errors", "repository_checks", column: "check_id", on_delete: :cascade
  add_foreign_key "repository_checks", "repositories"
end
