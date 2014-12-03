class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(user_id: current_user.id, body: comment_params[:body])
    @comment.save

    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
