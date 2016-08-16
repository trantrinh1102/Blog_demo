class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @entry  = current_user.entries.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
    else
      @feed_items = Entry.paginate(page: params[:page], per_page: 10)
    end
     @comment = Comment.new
  end

  def help
  end

  def about
  end
end
