class Product < ApplicationRecord
  belongs_to :category, primary_key: :external_id
  belongs_to :vendor
end
