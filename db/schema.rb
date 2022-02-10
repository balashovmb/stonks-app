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

ActiveRecord::Schema.define(version: 2022_02_09_062148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deals", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.integer "price", null: false
    t.integer "volume", null: false
    t.integer "direction", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "portfolio_id", null: false
    t.index ["portfolio_id"], name: "index_deals_on_portfolio_id"
    t.index ["stock_id"], name: "index_deals_on_stock_id"
  end

  create_table "favorite_stocks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "stock_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stock_id"], name: "index_favorite_stocks_on_stock_id"
    t.index ["user_id", "stock_id"], name: "index_favorite_stocks_on_user_id_and_stock_id", unique: true
    t.index ["user_id"], name: "index_favorite_stocks_on_user_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer "cash"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "ticker", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ticker"], name: "index_stocks_on_ticker", unique: true
  end

  create_table "subscribed_quotes", force: :cascade do |t|
    t.string "ticker", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ticker"], name: "index_subscribed_quotes_on_ticker", unique: true
  end

  create_table "trade_positions", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.bigint "portfolio_id", null: false
    t.integer "volume", null: false
    t.integer "average_price", null: false
    t.integer "direction", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["portfolio_id"], name: "index_trade_positions_on_portfolio_id"
    t.index ["stock_id"], name: "index_trade_positions_on_stock_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "deals", "portfolios"
  add_foreign_key "deals", "stocks"
  add_foreign_key "favorite_stocks", "stocks"
  add_foreign_key "favorite_stocks", "users"
  add_foreign_key "portfolios", "users"
  add_foreign_key "trade_positions", "portfolios"
  add_foreign_key "trade_positions", "stocks"
end
