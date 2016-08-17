class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  def create
    @entry = current_user.entries.build(micropost_params)
    if @entry.save
      flash[:success] = "entry created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @entry.destroy
    flash[:success] = "entry deleted"
    redirect_to root_url
  end

  def show
    @entry = Entry.find(params[:id])
    @comment = Comment.new if logged_in?
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(micropost_params)
      flash[:success] = t"flash.success.update"
      redirect_to @entry
    else
      render 'edit'
    end
  end

  private

    def micropost_params
      params.require(:entry).permit(:title, :content, :picture)
    end

    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
