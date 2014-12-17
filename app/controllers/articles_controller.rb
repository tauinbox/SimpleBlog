class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :destroy, :rating_inc, :rating_dec]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @article.images.build
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to @article, notice: "Article created"
    else
      render action: 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
    if current_user.id != @article.user_id
      @articles = Article.all
      @users = User.all
      render action: 'index', alert: I18n.t('flashes.cant_edit')
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render action: 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if current_user.id != @article.user_id
      @articles = Article.all
      @users = User.all
      render action: 'index', alert: I18n.t('flashes.cant_delete')
    else
      @article.destroy
      redirect_to articles_path
    end
  end

  def voteup
    @article = Article.find(params[:id])
    # flash[:notice] = @article.votes.where(user_id: current_user.id).first.inspect
    unless vote = @article.votes.where(user_id: current_user.id).first
      vote = @article.votes.new
      vote.user = current_user
    end
    if vote.value == 1
      flash[:notice] = 'Alredy voted'
    else
      vote.value += 1
      vote.save
    end
    #flash[:notice] = vote.inspect
    # redirect_to action: 'index'
    render json: {vote: vote.value}
  end

  def votedown
    @article = Article.find(params[:id])
    unless vote = @article.votes.where(user_id: current_user.id).first
      vote = @article.votes.new
      vote.user = current_user
    end
    if vote.value == -1
      flash[:notice] = 'Alredy voted'
    else
      vote.value -= 1
      vote.save
    end
    #flash[:notice] = vote.inspect
    redirect_to action: 'index'
  end

  def votemap
    @article = Article.find(params[:id])
    @votes = @article.votes
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, images_attributes: [:attachment, :description])
  end

end
