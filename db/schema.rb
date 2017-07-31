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

ActiveRecord::Schema.define(version: 20170729172849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "character_creations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "race"
    t.string "character_class"
    t.integer "level"
    t.integer "strength"
    t.integer "dexterity"
    t.integer "constitution"
    t.integer "intelligence"
    t.integer "wisdom"
    t.integer "charisma"
    t.string "proficiencies", array: true
    t.string "languages", array: true
    t.text "armor"
    t.text "shield"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "base_hit_points"
    t.integer "lost_hit_points", default: 0, null: false
    t.integer "sex"
    t.integer "alignment"
    t.string "personnality_traits", default: [], array: true
    t.string "ideals", default: [], array: true
    t.string "bonds", default: [], array: true
    t.string "flaws", default: [], array: true
    t.index ["languages"], name: "index_characters_on_languages", using: :gin
    t.index ["proficiencies"], name: "index_characters_on_proficiencies", using: :gin
  end

end
