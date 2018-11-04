module Fetcher
  class Categories
    def initialize(data)
      @data = data
    end

    def fetch
      Category.transaction do
        @data.xpath('//category').map do |category|
          Category.find_or_create_by(name: category.text, external_id: category[:id].to_i, parent_id: category[:parentId]&.to_i)
        end
      end
    end
  end
end
