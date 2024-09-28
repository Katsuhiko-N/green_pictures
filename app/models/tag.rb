class Tag < ApplicationRecord
    
    has_many :tag_lists, dependent: :destroy
    has_many :posts, through: :tag_lists
    
    # バリデーション
    validates :name, presence: true, length: {minimum: 1, maximum: 15}, uniqueness: true
    
end
