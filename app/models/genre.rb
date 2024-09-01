class Genre < ApplicationRecord
    
    # ジャンル機能は後で実装
    # has_many :posts
    # ジャンル消えても投稿は残す設定
    
    # バリデーション
    validates :name, presence: true
    
end
