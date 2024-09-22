class CreateGroupMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :group_messages do |t|
      
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.text :body, null: false
      
      t.timestamps
    end
  end
end
