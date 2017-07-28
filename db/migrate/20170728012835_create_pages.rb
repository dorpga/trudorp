class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.string :path
      t.text :body

      t.timestamps null: false
    end
  end
end
