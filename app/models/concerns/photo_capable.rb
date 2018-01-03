module PhotoCapable
  extend ActiveSupport::Concern

  included do
    has_many :photos, through: :photographings, as: :photographable
    has_many :photographings, as: :photographable, dependent: :destroy

    scope :has_photos, -> { includes(:photos).where.not(photos: { id: nil }) }

    # use the first available photo linked to this item
    # if no photos, use a photo from the crop
    # Note, Garden over-rides this because it has no crop
    def default_photo
      # most recent photo
      return photos.order(created_at: :desc).first if photos.any?
      crop.default_photo
    end
  end
end
