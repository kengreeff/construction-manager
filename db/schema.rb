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

ActiveRecord::Schema[7.1].define(version: 2024_01_04_030428) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "title", null: false
    t.string "key", null: false
    t.string "category_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.bigint "organization_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_clients_on_organization_id"
  end

  create_table "clients_projects", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_clients_projects_on_client_id"
    t.index ["project_id"], name: "index_clients_projects_on_project_id"
  end

  create_table "clients_users", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_clients_users_on_client_id"
    t.index ["user_id"], name: "index_clients_users_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "record_type"
    t.bigint "record_id"
    t.bigint "user_id"
    t.text "body"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id"], name: "index_comments_on_record"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "quote_id"
    t.bigint "supplier_id", null: false
    t.bigint "user_id", null: false
    t.string "reference"
    t.text "description"
    t.decimal "total", precision: 8, scale: 2
    t.datetime "issue_date"
    t.datetime "due_date"
    t.bigint "paid_by_user_id"
    t.datetime "paid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_invoices_on_project_id"
    t.index ["quote_id"], name: "index_invoices_on_quote_id"
    t.index ["supplier_id"], name: "index_invoices_on_supplier_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations_projects", force: :cascade do |t|
    t.bigint "organization_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_organizations_projects_on_organization_id"
    t.index ["project_id"], name: "index_organizations_projects_on_project_id"
  end

  create_table "organizations_users", force: :cascade do |t|
    t.bigint "organization_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_organizations_users_on_organization_id"
    t.index ["user_id"], name: "index_organizations_users_on_user_id"
  end

  create_table "project_items", force: :cascade do |t|
    t.bigint "project_space_id"
    t.string "title", null: false
    t.integer "quantity", default: 1
    t.bigint "supplier_id"
    t.text "description"
    t.string "product_code"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.string "internal_code"
    t.decimal "unit_price", precision: 8, scale: 2
    t.string "finish"
    t.string "material"
    t.string "colour"
    t.bigint "project_id"
    t.bigint "approved_by_user_id"
    t.datetime "approved_at"
    t.bigint "status_id"
    t.index ["category_id"], name: "index_project_items_on_category_id"
    t.index ["project_id"], name: "index_project_items_on_project_id"
    t.index ["project_space_id"], name: "index_project_items_on_project_space_id"
    t.index ["status_id"], name: "index_project_items_on_status_id"
    t.index ["supplier_id"], name: "index_project_items_on_supplier_id"
  end

  create_table "project_spaces", force: :cascade do |t|
    t.bigint "project_id"
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_spaces_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_master", default: false, null: false
    t.bigint "parent_project_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "supplier_id", null: false
    t.bigint "user_id", null: false
    t.string "reference"
    t.text "description"
    t.decimal "total", precision: 8, scale: 2
    t.datetime "issue_date"
    t.datetime "expiry_date"
    t.bigint "accepted_by_user_id"
    t.datetime "accepted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_quotes_on_project_id"
    t.index ["supplier_id"], name: "index_quotes_on_supplier_id"
    t.index ["user_id"], name: "index_quotes_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "title"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sort", default: 0
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "users"
  add_foreign_key "invoices", "projects"
  add_foreign_key "invoices", "quotes"
  add_foreign_key "invoices", "suppliers"
  add_foreign_key "invoices", "users"
  add_foreign_key "project_items", "categories"
  add_foreign_key "project_items", "projects"
  add_foreign_key "project_items", "statuses"
  add_foreign_key "quotes", "projects"
  add_foreign_key "quotes", "suppliers"
  add_foreign_key "quotes", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "users", "roles"
end
