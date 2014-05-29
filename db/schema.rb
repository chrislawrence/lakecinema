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

ActiveRecord::Schema.define(version: 20140518023118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "holidays", force: true do |t|
    t.integer  "week_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "preamble"
    t.text     "body"
  end

  create_table "movies", force: true do |t|
    t.string   "title"
    t.string   "rating"
    t.string   "poster_url"
    t.string   "week_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
    t.text     "overview"
    t.string   "extra"
    t.integer  "view_index"
    t.integer  "tmdb_id"
  end

  create_table "newsletters", force: true do |t|
    t.string   "subject"
    t.integer  "week_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "campaign_id"
    t.text     "body"
    t.text     "introduction"
    t.datetime "send_time"
  end

  create_table "showings", force: true do |t|
    t.string   "day"
    t.string   "times"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "view_index", default: 0
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  create_table "weeks", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
