class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.string :title
      t.text :body
      t.integer :author_id

      t.timestamps null: false
    end
  end
end
