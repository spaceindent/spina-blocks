class CreateBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table "spina_blocks", force: :cascade do |t|
      t.string   "title"
      t.string   "description"
      t.string   "slug"
      t.boolean  "deletable",           default: true
      t.datetime "created_at",          null: false
      t.datetime "updated_at",          null: false
      t.string   "name"
      t.string   "view_template"
      t.string   "layout_template"
      t.boolean  "draft",               default: false
      t.boolean  "active",              default: true
    end

    Spina::Block.create_translation_table! title: :string, description: :string

    create_table "spina_block_parts", force: :cascade do |t|
      t.string   "title"
      t.string   "name"
      t.datetime "created_at",         null: false
      t.datetime "updated_at",         null: false
      t.integer  "block_id"
      t.integer  "page_partable_id"
      t.string   "page_partable_type"
    end
  end
end
