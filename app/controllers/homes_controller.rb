class HomesController < ApplicationController
    
    def top
        
    end
    
    def v_test
        if user_signed_in?
            @user = User.find(current_user.id)
        end
    end
end
