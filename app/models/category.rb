class Category < ApplicationRecord
  belongs_to :parent_category, foreign_key: :parent_id, primary_key: :external_id, optional: true, class_name: 'Category'
  has_many :subcategories, foreign_key: :parent_id, primary_key: :external_id, class_name: 'Category'
end
