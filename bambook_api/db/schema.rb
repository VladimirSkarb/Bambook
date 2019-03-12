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

ActiveRecord::Schema.define(version: 2019_03_12_174127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "cover_photo"
    t.string "book_file"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "money_transactions", force: :cascade do |t|
    t.integer "amount"
    t.integer "operation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "wallet_id"
    t.index ["wallet_id"], name: "index_money_transactions_on_wallet_id"
  end

  create_table "offer_subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "offer_id"
    t.index ["offer_id"], name: "index_offer_subscriptions_on_offer_id"
    t.index ["user_id"], name: "index_offer_subscriptions_on_user_id"
  end

  create_table "offers", force: :cascade do |t|
    t.date "deadline"
    t.string "link"
    t.integer "minimum_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "status"
    t.string "avatar"
    t.string "title"
    t.string "author"
    t.integer "price"
    t.integer "contribution"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "comment"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "book_id"
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallets", force: :cascade do |t|
    t.integer "available_money", default: 0
    t.integer "frozen_money", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "books", "users"
  add_foreign_key "money_transactions", "wallets"
  add_foreign_key "offer_subscriptions", "offers"
  add_foreign_key "offer_subscriptions", "users"
  add_foreign_key "offers", "users"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
  add_foreign_key "wallets", "users"
end
