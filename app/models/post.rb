class Post < ApplicationRecord
    
    has_one_attached :image
    
    has_many :comments, dependent: :destroy
    belongs_to :user
    belongs_to :genre
    
    # バリデーション
    validates :title, presence: true
    validates :body, presence: true
    validates :image, presence: true
    
    
end
