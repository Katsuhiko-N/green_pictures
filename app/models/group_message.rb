class GroupMessage < ApplicationRecord
    
    belongs_to :user
    belongs_to :group
    
    # バリデーション
    validates :body, presence: true, length: {minimum: 1, maximum: 100}
    
end
