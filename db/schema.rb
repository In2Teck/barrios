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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130817230156) do

  create_table "neighborhoods", :force => true do |t|
    t.string   "name"
    t.string   "picture_url_thumb"
    t.string   "picture_url_normal"
    t.string   "picture_url_big"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "runs", :force => true do |t|
    t.integer  "user_id"
    t.string   "run_id"
    t.string   "run_url"
    t.float    "kilometers"
    t.float    "pace"
    t.datetime "published_date"
    t.datetime "start_date"
    t.boolean  "accounted"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "facebook_id"
    t.string   "twitter_id"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "facebook_hash"
    t.text     "twitter_hash"
    t.string   "last_twitt_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "access_token"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
    t.datetime "last_facebook_run"
    t.integer  "neighborhood_id"
    t.float    "kilometers"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
