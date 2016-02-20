class Recipe < ActiveRecord::Base
  has_many :ingredients, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }
end
