class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    if user_signed_in?
      @friends = current_user.friends.decorate
      render "home", locals: {friends: @friends}
    else
      render "index"
    end
  end
end
