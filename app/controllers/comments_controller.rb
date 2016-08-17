class CommentsController < ApplicationController

   def create
    @entry = Entry.find_by(id: params[:comment][:entry_id])
    @comment = @entry.comments.build(comment_params)
    if @comment.save
      flash[:success] = t"flash.success.comment.create"
    else
      flash[:danger] = t"flash.danger.comment.danger"
    end
    redirect_to @entry
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
    flash[:success] = t"flash.success.comment.deleted"
    redirect_to request.referrer || root_url
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
