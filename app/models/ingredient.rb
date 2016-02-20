class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  has_one :product
end
