class Post < ApplicationRecord
    
    has_one_attached :image
    
    has_many :comments, dependent: :destroy
    has_many :tag_lists, dependent: :destroy
    has_many :tag, through: :tag_lists
    
    belongs_to :user
    # ジャンル機能は後で実装
    # belongs_to :genre
    
    # バリデーション
    validates :title, presence: true
    validates :body, presence: true
    validates :image, presence: true
    
    
end
