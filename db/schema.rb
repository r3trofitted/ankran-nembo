# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_01_161702) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "personality_traits", default: [], array: true
    t.string "ideals", default: [], array: true
    t.string "bonds", default: [], array: true
    t.string "flaws", default: [], array: true
    t.index ["languages"], name: "index_characters_on_languages", using: :gin
    t.index ["proficiencies"], name: "index_characters_on_proficiencies", using: :gin
  end

end
