class CreateForumCategories < ActiveRecord::Migration
  def change
    create_table :forum_categories do |t|
      t.string :title
      t.string :description

      t.timestamps null: false
    end
  end
end
