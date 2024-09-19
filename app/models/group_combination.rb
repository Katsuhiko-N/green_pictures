class GroupCombination < ApplicationRecord
        
    belongs_to :user
    belongs_to :group
    
    
    # バリデーション
    validates :user_id, presence: true
    validates :group_id, presence: true
    
end
