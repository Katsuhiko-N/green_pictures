class CreateGroupCombinations < ActiveRecord::Migration[6.1]
  def change
    create_table :group_combinations do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.timestamps
    end
  end
end
