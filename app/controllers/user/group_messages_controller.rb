class User::GroupMessagesController < ApplicationController
    
    def create
    end
    
    
    private
    
    def message_params
        params.require(:group_message).parmit
    
    
    
end
