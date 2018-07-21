ActiveRecord::Schema.define(version: 20180721090544) do

  enable_extension "plpgsql"

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "user_id"
    t.string "image"
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "blog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "blogs", "users"
end
