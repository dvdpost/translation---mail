# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100322140655) do

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "short"
    t.integer  "entity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keys", :force => true do |t|
    t.string   "page"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keys_translations", :force => true do |t|
    t.integer  "reference_id"
    t.integer  "language_id"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "keys_translations", ["reference_id"], :name => "index_keys_translations_on_reference_id"

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_messages", :id => false, :force => true do |t|
    t.integer "mail_messages_id",              :default => 0,  :null => false
    t.integer "language_id"
    t.string  "messages_subject"
    t.string  "messages_title"
    t.text    "messages_html"
    t.string  "comment",          :limit => 0, :default => "", :null => false
    t.boolean "newsletter"
    t.boolean "viewable"
  end

  create_table "mails", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "newsletter"
    t.boolean  "viewable"
    t.boolean  "deleted",    :default => false
  end

  create_table "references", :force => true do |t|
    t.integer  "key_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "references", ["key_id"], :name => "index_references_on_key_id"

  create_table "translation2", :id => false, :force => true do |t|
    t.integer "translation_id",    :default => 0, :null => false
    t.integer "site_host_id",      :default => 0, :null => false
    t.text    "translation_value"
    t.integer "language_id"
    t.string  "translation_page"
    t.string  "translation_key"
    t.integer "entity_id"
  end

  create_table "translations", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "language_id"
    t.integer  "mail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "translations", ["mail_id", "language_id"], :name => "index_translations_on_mail_id_and_language_id", :unique => true

end
