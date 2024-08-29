class CreateGroupCombinations < ActiveRecord::Migration[6.1]
  def change
    create_table :group_combinations do |t|

      t.timestamps
    end
  end
end
