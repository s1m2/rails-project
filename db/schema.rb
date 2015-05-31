# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150410194119) do

  create_table "conversations", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id", using: :btree
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id", using: :btree

  create_table "messages", force: true do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "project_activities", force: true do |t|
    t.integer  "project_id"
    t.integer  "asignor_id"
    t.text     "task"
    t.text     "activity"
    t.integer  "assignee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "completed",   default: 0
  end

  add_index "project_activities", ["asignor_id"], name: "index_project_activities_on_asignor_id", using: :btree
  add_index "project_activities", ["assignee_id"], name: "index_project_activities_on_assignee_id", using: :btree
  add_index "project_activities", ["project_id"], name: "index_project_activities_on_project_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "project_name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "creator"
  end

  create_table "users", force: true do |t|
    t.string   "first_name",      limit: 50
    t.string   "lastname",        limit: 50
    t.string   "email",           limit: 100
    t.string   "department",      limit: 40
    t.string   "role",            limit: 50
    t.string   "username",        limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
