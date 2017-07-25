class CreateBlogTaggings < ActiveRecord::Migration
  def change
    create_table :blog_taggings do |t|
      t.belongs_to :blog_post, index: true, foreign_key: true
      t.belongs_to :blog_tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
