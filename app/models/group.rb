class Group < ApplicationRecord
    
    has_one_attached :g_image
    
    has_many :group_combinations, dependent: :destroy
    has_many :group_comments, dependent: :destroy
    
    
    # グループ画像呼び出しメソッド
    def show_g_img(width,height)
        # 画像未設定の場合
        unless g_image.attached?
          file_path = Rails.root.join('app/assets/images/group_no_image.jpg')
          image.attach(io: File.open(file_path), filename: 'default-g_image.jpg', content_type: 'image/jpg')
        end
        g_image.variant(resize_to_limit: [width, height]).processed
    end
  
    
end
