class User::GroupCombinationsController < ApplicationController
  
  # 
  def create
    g_combination = GroupCombination.new(group_id: params[:group_id])
    g_combination.user_id = current_user.id
    g_combination.save
    redirect_to group_path(params[:group_id])
  end

  def destroy
    group = Group.find(params[:id])
    g_combination = GroupCombination.find_by(user_id: current_user.id, group_id: group.id)
    g_combination.destroy!
    redirect_to group_path(params[:group_id])
  end
end
