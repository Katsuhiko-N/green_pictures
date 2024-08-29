class Group < ApplicationRecord
    
    has_one_attached :g_image
    
    has_many :group_combinations, dependent: :destroy
    has_many :group_comments, dependent: :destroy
    
end
