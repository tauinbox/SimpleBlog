class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :destroy]

  def index
    @articles = Article.all
    @users = User.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to @article
    else
      render action: 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
    if current_user.id != @article.user_id
      flash.now[:error] = "YOU CAN'T EDIT OTHER PEOPLE'S POSTS!"
      @articles = Article.all
      @users = User.all
      render action: 'index'
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
      flash.now[:error] = "YOU CAN'T DELETE OTHER PEOPLE'S POSTS!"
      @articles = Article.all
      @users = User.all
      render action: 'index'
    else
      @article.destroy
      redirect_to articles_path
    end

  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

end
