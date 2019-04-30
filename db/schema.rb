# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_30_200905) do

  create_table "tip_ratings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "tip_id"
    t.boolean "good_tip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tip_id"], name: "index_tip_ratings_on_tip_id"
    t.index ["user_id"], name: "index_tip_ratings_on_user_id"
  end

  create_table "tips", force: :cascade do |t|
    t.integer "topic_id"
    t.string "title"
    t.string "link"
    t.text "benefit"
    t.string "tip_type"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_tips_on_topic_id"
    t.index ["user_id"], name: "index_tips_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.integer "course_order"
    t.integer "user_id"
    t.string "course_name"
    t.integer "course_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "bootcamp_student"
    t.boolean "has_graduated"
    t.string "camp_organization"
    t.string "provider_id"
    t.string "provider", default: "learnHELP"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
