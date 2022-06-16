class ArticlesController < ApplicationController
  before_action :has_news_posting_auth?, only:[:edit,:update,:destroy]

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
      render new_article_path
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def sort_column
    params[:sort] ? params[:sort] : 'created_at'
  end

  def sort_direction
    params[:direction] ? params[:direction] : 'asc'
  end

  def has_news_posting_auth?
    redirect_to articles_path unless current_user.news_posting_auth
  end
end
