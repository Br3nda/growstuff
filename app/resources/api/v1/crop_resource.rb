module Api
  module V1
    class CropResource < BaseResource
      immutable

      filter :approval_status, default: 'approved'
      filter :perennial

      has_many :plantings
      has_many :seeds
      has_many :harvests

      has_many :photos

      attributes :name, :default_scientific_name
      attributes :en_wikipedia_url, :slug
      attributes :perennial, :median_lifespan, :median_days_to_first_harvest, :median_days_to_last_harvest
      attributes :created_at, :updated_at

      attribute :thumbnail
      def thumbnail
        @model.default_photo&.thumbnail_url
      end

      filter :interesting, apply: lambda { |records, value, _options|
        if value
          records.interesting
        else
          records
        end
      }

      filter :random, apply: lambda { |records, value, _options|
        if value
          records.shuffle
        else
          records
        end
      }
    end
  end
end
