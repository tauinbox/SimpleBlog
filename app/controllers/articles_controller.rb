class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :destroy]

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

  private

  def article_params
    params.require(:article).permit(:title, :text, images_attributes: [:attachment, :description])
  end

end
