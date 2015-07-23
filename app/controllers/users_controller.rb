class UsersController < ApplicationController
  def show
    @user = User.find_by_minecraft_username(params[:id]).decorate
    @friends = @user.friends.decorate
  end

  def friend_request
    @user = User.find_by_minecraft_username(params[:id]).decorate
    req = current_user.sent_friend_requests.where(friend: @user).first
    if req
      flash[:error] = "You have already sent a friend request to this person."
    else
      current_user.friend_requests.create!(friend: @user)
      flash[:success] = "Sent friend request."
    end
    redirect_to :back
  end

  def accept_request
    @user = User.find_by_minecraft_username(params[:id]).decorate
    req = current_user.received_friend_requests.where(user: @user).first
    if req
      req.accept!
      flash[:success] = "Added friend."
    else
      flash[:error] = "No friend request found."
    end
    redirect_to :back
  end
end
