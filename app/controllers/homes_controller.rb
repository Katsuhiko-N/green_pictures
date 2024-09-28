class HomesController < ApplicationController
    
    def top
        
    end
    
    # テストページ
    def v_test
        @tags = Tag.all
    end
end
