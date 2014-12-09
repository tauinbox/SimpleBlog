class AddRatingFieldsToArticleCommentProfile < ActiveRecord::Migration
  def change
    add_column :articles, :rating, :integer, default: 0
    add_column :comments, :rating, :integer, default: 0
    add_column :profiles, :rating, :integer, default: 0
  end
end
