class Genre < ApplicationRecord
    
    has_many :posts
    # ジャンル消えても投稿は残したい
    
end