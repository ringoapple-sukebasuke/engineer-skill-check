class AddAuthorToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :Author, :integer
  end
end
