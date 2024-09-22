class CreateGroupMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_members do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      # 加入ステータスカラム
      t.boolean :is_active, null: false, default: 'FALSE'
      t.timestamps
    end
  end
end
