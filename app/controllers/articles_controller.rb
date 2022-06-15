class ArticlesController < ApplicationController
  
  def index
    @articles = Article.order("#{sort_column} #{sort_direction}")
  end

  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path
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
end
