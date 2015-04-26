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

ActiveRecord::Schema.define(version: 20150425233309) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "holidays", force: :cascade do |t|
    t.integer  "week_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "preamble"
    t.text     "body"
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.string   "rating",              limit: 255
    t.string   "poster_url",          limit: 255
    t.string   "week_id",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "poster_file_name",    limit: 255
    t.string   "poster_content_type", limit: 255
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
    t.text     "overview"
    t.string   "extra",               limit: 255
    t.integer  "view_index"
    t.integer  "tmdb_id"
    t.string   "backdrop",            limit: 255
    t.string   "cast",                            array: true
    t.string   "director",            limit: 255
    t.integer  "newsletter_id"
    t.text     "after"
  end

  create_table "newsletters", force: :cascade do |t|
    t.string   "subject",      limit: 255
    t.integer  "week_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "campaign_id",  limit: 255
    t.text     "introduction"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "body"
    t.date     "send_date"
  end

  create_table "showings", force: :cascade do |t|
    t.string   "day",        limit: 255
    t.string   "times",      limit: 255
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",           limit: 255
  end

  create_table "weeks", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category",   limit: 255, default: "standard"
    t.text     "body"
  end

end
