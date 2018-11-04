module Fetcher
  class Products
    AVAILABLE_CATEGORIES = [2844].freeze

    def initialize(data)
      @data = data
    end

    def fetch
      create_products
    end

    private

    def create_products
      Product.transaction do
        available_products_data.map do |product_data|
          Product.find_or_create_by(product_data)
        end
      end
    end

    def available_products_data
      products = parsed_products.select { |product| AVAILABLE_CATEGORIES.include?(product[:category_id]) }
      products.map do |product|
        product[:vendor_id] = vendor(product[:vendor_id])
        product
      end
    end

    def parsed_products
      @data.xpath('//offer').map do |offer|
        product_fields(offer).merge(references(offer)).merge(urls(offer))
      end
    end

    def product_fields(offer)
      {
        available: offer[:available] == 'true',
        delivery: offer.children[11].text == 'true',
        price: offer.children[3].text.to_i,
        name: offer.children[13].text
      }
    end

    def references(offer)
      {
        external_id: offer[:id].to_i,
        vendor_id: offer.children[15].text,
        vendor_code: offer.children[17].text,
        category_id: offer.children[7].text.to_i
      }
    end

    def urls(offer)
      {
        seller_url: offer.children[1].children.text,
        image_url: offer.children[9].text
      }
    end

    def vendor(name)
      Vendor.find_or_create_by(name: name).id
    end
  end
end
