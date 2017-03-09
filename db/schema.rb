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

ActiveRecord::Schema.define(version: 20170309222844) do

  create_table "agent_commissions", primary_key: ["id", "week_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "id",              null: false
    t.integer  "week_id",         null: false
    t.integer  "master_agent_id"
    t.integer  "coin"
    t.integer  "value"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "markets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "master_agents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.float    "commission", limit: 24
    t.string   "login"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "member_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "member_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "sevens_id",       limit: 45
    t.string   "login",           limit: 45
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "source"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "master_agent_id"
  end

  create_table "position_takings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "member_id"
    t.integer  "market_id"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "member_id"
    t.integer  "rate"
    t.string   "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settlement_summaries", primary_key: ["id", "week_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "id",               null: false
    t.integer  "week_id",          null: false
    t.integer  "value"
    t.integer  "downline"
    t.integer  "upline"
    t.integer  "agent_commission"
    t.integer  "profit_loss"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "settlements", primary_key: ["id", "week_id"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "id",         null: false
    t.integer  "member_id"
    t.string   "source"
    t.integer  "week_id",    null: false
    t.date     "from_date"
    t.date     "end_date"
    t.integer  "coin"
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_settlement_summaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "week_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "login"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "password_digest"
    t.float    "share_holding",   limit: 24
  end

end
