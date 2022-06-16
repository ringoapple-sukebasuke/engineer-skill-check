class ArticlesController < ApplicationController
  before_action :has_news_posting_auth?, only:[:new, :edit,:update,:destroy]

  def index
    @articles = Article.order("#{sort_column} #{sort_direction}")
  end

  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path, notice: "投稿が完了しました"
    else
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to articles_path, notice: "「#{@article.title} 」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: "「#{@article.title}」を削除しました。"
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def sort_column
    params[:sort] ? params[:sort] : 'created_at'
  end

  def sort_direction
    params[:direction] ? params[:direction] : 'desc'
  end

  def has_news_posting_auth?
    redirect_to articles_path unless current_user.news_posting_auth
  end
end
