class AddReviewToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :review, :float
  end
end
