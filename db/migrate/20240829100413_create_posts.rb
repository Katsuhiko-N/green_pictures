class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      
      t.integer :user_id, null: false
      # ジャンル機能は後で実装
      # t.integer :genre_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      
      t.timestamps
    end
  end
end
