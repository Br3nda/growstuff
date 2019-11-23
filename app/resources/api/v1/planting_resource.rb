module Api
  module V1
    class PlantingResource < BaseResource
      immutable

      has_one :garden
      has_one :crop
      has_one :owner, class_name: 'Member'
      has_many :photos
      has_many :harvests

      attribute :planted_at
      attribute :finished
      attribute :finished_at
      attribute :quantity
      attribute :description
      attributes :sunniness, :planted_from
      attributes :active?, :finished?

      # Predictions
      attribute :expected_lifespan
      attribute :finish_predicted_at
      attribute :first_harvest_date
      attribute :last_harvest_date

      # crops
      attributes :crop_name, :crop_perennial, :crop_slug
      attribute :owner_login_name
      attributes :longitude, :latitude, :location

      # calculated attributes
      attribute :percentage_grown
      def percentage_grown
        @model.percentage_grown.to_i
      end

      attribute :thumbnail
      def thumbnail
        @model.default_photo&.thumbnail_url
      end

      filter :crop
      filter :crop_id
      filter :finished
      filter :garden
      filter :garden_id
      filter :owner
      filter :owner_id
      filter :planted_from
      filter :slug
      filter :active, apply: lambda { |records, value, _options|
        if value
          records.active
        else
          records.not.active
        end
      }

      filter :interesting, apply: lambda { |records, value, _options|
        if value
          records.interesting
        else
          records
        end
      }

      filter :perennial, apply: lambda { |records, value, _options|
        records.joins(:crop).where(crops: { perennial: value })
      }
    end
  end
end
