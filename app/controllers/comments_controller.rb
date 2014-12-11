class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :voteup, :votedown]

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(user_id: current_user.id, body: comment_params[:body])
    @comment.save

    redirect_to article_path(@article)
  end

   def voteup
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
    # flash[:notice] = @article.votes.where(user_id: current_user.id).first.inspect
    unless vote = @comment.votes.where(user_id: current_user.id).first
      vote = @comment.votes.new
      vote.user = current_user
    end
    if vote.value == 1
      flash[:notice] = 'Alredy voted'
    else
      vote.value += 1
      vote.save
    end
    #flash[:notice] = vote.inspect
    redirect_to @article
  end

   def votedown
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
    # flash[:notice] = @article.votes.where(user_id: current_user.id).first.inspect
    unless vote = @comment.votes.where(user_id: current_user.id).first
      vote = @comment.votes.new
      vote.user = current_user
    end
    if vote.value == -1
      flash[:notice] = 'Alredy voted'
    else
      vote.value -= 1
      vote.save
    end
    #flash[:notice] = vote.inspect
    redirect_to @article
  end

  def votemap
    @comment = Comment.find(params[:id])
    @votes = @comment.votes
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
