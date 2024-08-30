class Post < ApplicationRecord
    
    has_one_attached :image
    
    has_many :comments, dependent: :destroy
    belongs_to :user
    belongs_to :genre
    
    
end
