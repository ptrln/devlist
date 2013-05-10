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

ActiveRecord::Schema.define(:version => 20130510162257) do

  create_table "analyticals", :force => true do |t|
    t.string   "page_path",        :null => false
    t.integer  "exits",            :null => false
    t.integer  "pageviews",        :null => false
    t.integer  "visitors",         :null => false
    t.integer  "new_visits",       :null => false
    t.integer  "entrances",        :null => false
    t.integer  "unique_pageviews", :null => false
    t.float    "time_on_page",     :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "analyticals", ["page_path"], :name => "index_analyticals_on_page_path", :unique => true

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "follows", :force => true do |t|
    t.string   "followable_type"
    t.integer  "followable_id"
    t.integer  "follower_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "follows", ["followable_type", "followable_id", "follower_id"], :name => "follows_combo_index", :unique => true
  add_index "follows", ["followable_type", "followable_id"], :name => "index_follows_on_followable_type_and_followable_id"
  add_index "follows", ["follower_id"], :name => "index_follows_on_follower_id"

  create_table "github_panels", :force => true do |t|
    t.integer  "user_id",             :null => false
    t.integer  "verified_github_id",  :null => false
    t.string   "language_count_json", :null => false
    t.string   "login",               :null => false
    t.string   "url",                 :null => false
    t.integer  "public_repos",        :null => false
    t.integer  "total_repos",         :null => false
    t.integer  "followers",           :null => false
    t.integer  "following",           :null => false
    t.datetime "github_created_at",   :null => false
    t.datetime "github_updated_at",   :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "github_panels", ["user_id"], :name => "index_github_panels_on_user_id"
  add_index "github_panels", ["verified_github_id"], :name => "index_github_panels_on_verified_github_id", :unique => true

  create_table "message_chains", :force => true do |t|
    t.string "user1",           :null => false
    t.string "user2",           :null => false
    t.date   "user1_last_read"
    t.date   "user2_last_read"
  end

  add_index "message_chains", ["user1", "user2"], :name => "index_message_chains_on_user1_and_user2", :unique => true
  add_index "message_chains", ["user1"], :name => "index_message_chains_on_user1"
  add_index "message_chains", ["user2"], :name => "index_message_chains_on_user2"

  create_table "messages", :force => true do |t|
    t.integer  "from_id",                       :null => false
    t.integer  "to_id",                         :null => false
    t.boolean  "is_read",    :default => false
    t.text     "body",                          :null => false
    t.integer  "chain_id",                      :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "messages", ["chain_id"], :name => "index_messages_on_chain_id"
  add_index "messages", ["from_id"], :name => "index_messages_on_from_id"
  add_index "messages", ["to_id"], :name => "index_messages_on_to_id"

  create_table "notifications", :force => true do |t|
    t.string   "notifiable_type", :null => false
    t.integer  "notifiable_id",   :null => false
    t.string   "message",         :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "notifications", ["notifiable_id", "notifiable_type"], :name => "index_notifications_on_notifiable_id_and_notifiable_type"

  create_table "project_answers", :force => true do |t|
    t.integer  "question_id", :null => false
    t.string   "body",        :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "project_answers", ["question_id"], :name => "index_project_answers_on_question_id"

  create_table "project_images", :force => true do |t|
    t.string   "url",        :null => false
    t.integer  "ordering",   :null => false
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "project_images", ["project_id"], :name => "index_project_images_on_project_id"

  create_table "project_questions", :force => true do |t|
    t.integer  "project_id", :null => false
    t.string   "body",       :null => false
    t.integer  "asker_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "project_questions", ["asker_id"], :name => "index_project_questions_on_asker_id"
  add_index "project_questions", ["project_id"], :name => "index_project_questions_on_project_id"

  create_table "project_updates", :force => true do |t|
    t.integer  "project_id", :null => false
    t.string   "body",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_contacts", :force => true do |t|
    t.string   "t"
    t.string   "info"
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_contacts", ["user_id"], :name => "index_user_contacts_on_user_id"

  create_table "user_csses", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.text     "css",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_csses", ["user_id"], :name => "index_user_csses_on_user_id", :unique => true

  create_table "user_educations", :force => true do |t|
    t.string   "school",        :null => false
    t.string   "degree",        :null => false
    t.string   "result",        :null => false
    t.text     "description",   :null => false
    t.integer  "user_id",       :null => false
    t.date     "graduate_date", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "user_educations", ["user_id"], :name => "index_user_educations_on_user_id"

  create_table "user_photos", :force => true do |t|
    t.string   "url",        :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_photos", ["user_id"], :name => "index_user_photos_on_user_id", :unique => true

  create_table "user_profiles", :force => true do |t|
    t.string   "name"
    t.string   "headline"
    t.text     "template"
    t.text     "summary"
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_profiles", ["user_id"], :name => "index_user_profiles_on_user_id", :unique => true

  create_table "user_projects", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.string   "title",         :null => false
    t.date     "creation_date"
    t.string   "summary"
    t.text     "description"
    t.string   "technologies"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "link"
    t.string   "source_link"
  end

  add_index "user_projects", ["user_id"], :name => "index_user_projects_on_user_id"

  create_table "user_skills", :force => true do |t|
    t.string   "name",        :null => false
    t.integer  "proficiency", :null => false
    t.integer  "user_id",     :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_skills", ["user_id"], :name => "index_user_skills_on_user_id"

  create_table "user_verified_contacts", :force => true do |t|
    t.string   "t",          :null => false
    t.string   "info",       :null => false
    t.text     "auth",       :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_verified_contacts", ["user_id"], :name => "index_user_verified_contacts_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :null => false
    t.string   "screen_name",                           :null => false
    t.string   "encrypted_password",                    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.datetime "notification_time"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["screen_name"], :name => "index_users_on_screen_name", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
