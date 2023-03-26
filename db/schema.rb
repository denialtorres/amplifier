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

ActiveRecord::Schema[7.0].define(version: 2023_03_26_210943) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "amplifier_status", ["draft", "published", "archived"]
  create_enum "conversation_type", ["question", "answer"]
  create_enum "speaker_type", ["ai", "human"]

  create_table "amplifier_conversations", force: :cascade do |t|
    t.text "content"
    t.bigint "amplifier_id"
    t.enum "conversation_type", enum_type: "conversation_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amplifier_id"], name: "index_amplifier_conversations_on_amplifier_id"
  end

  create_table "amplifier_prompt_categories", force: :cascade do |t|
    t.string "title"
    t.string "prompt"
    t.bigint "amplifier_prompt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amplifier_prompt_id"], name: "index_amplifier_prompt_categories_on_amplifier_prompt_id"
  end

  create_table "amplifier_prompts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "amplifier_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amplifier_type_id"], name: "index_amplifier_prompts_on_amplifier_type_id"
  end

  create_table "amplifier_types", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "amplifiers", force: :cascade do |t|
    t.integer "client_id"
    t.string "title"
    t.datetime "start_at"
    t.enum "state", enum_type: "amplifier_status"
    t.bigint "user_id"
    t.text "description"
    t.bigint "amplifier_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amplifier_type_id"], name: "index_amplifiers_on_amplifier_type_id"
    t.index ["client_id"], name: "index_amplifiers_on_client_id"
    t.index ["user_id"], name: "index_amplifiers_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "file_type"
    t.string "url"
    t.bigint "amplifier_conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amplifier_conversation_id"], name: "index_attachments_on_amplifier_conversation_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.enum "speaker", enum_type: "speaker_type"
    t.bigint "amplifier_conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amplifier_conversation_id"], name: "index_messages_on_amplifier_conversation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "amplifier_conversations", "amplifiers"
  add_foreign_key "amplifier_prompt_categories", "amplifier_prompts"
  add_foreign_key "amplifier_prompts", "amplifier_types"
  add_foreign_key "amplifiers", "amplifier_types"
  add_foreign_key "amplifiers", "users"
  add_foreign_key "attachments", "amplifier_conversations"
  add_foreign_key "messages", "amplifier_conversations"
end
