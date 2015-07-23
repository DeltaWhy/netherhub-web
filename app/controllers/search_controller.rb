class SearchController < ApplicationController
  def search
    if params[:q].present? and params[:q].length > 3
      @users = User.where('minecraft_username ILIKE ?', "%#{params[:q]}%").where.not(id: current_user.id).limit(10).order(:minecraft_username).decorate
    else
      @users = []
    end
  end
end
