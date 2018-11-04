module Fetcher
  class Service
    def initialize(file_path)
      @data = File.open(file_path) { |f| Nokogiri::XML(f) }
    end

    def fetch
      categories
      products
    end

    private

    def categories
      @categories ||= Fetcher::Categories.new(@data).fetch
    end

    def products
      @products ||= Fetcher::Products.new(@data).fetch
    end
  end
end
