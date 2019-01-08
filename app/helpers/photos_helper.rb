module PhotosHelper
  def crop_image_path(crop)
    if crop.default_photo.present?
      crop.default_photo.thumbnail_url
    else
      placeholder_image
    end
  end

  def garden_image_path(garden)
    if garden.default_photo.present?
      garden.default_photo.thumbnail_url
    else
      placeholder_image
    end
  end

  def planting_image_path(planting, before_date=Time.zone.now)
    if planting.photos.where('date_taken <= ?', before_date).size.positive?
      planting.photo(before_date).thumbnail_url
    else
      placeholder_image
    end
  end

  def harvest_image_path(harvest)
    if harvest.photos.present?
      harvest.default_photo.thumbnail_url
    elsif harvest.planting.present?
      planting_image_path(harvest.planting)
    else
      placeholder_image
    end
  end

  def seed_image_path(seed)
    if seed.default_photo.present?
      seed.default_photo.thumbnail_url
    elsif seed.crop.default_photo.present?
      seed.crop.default_photo.thumbnail_url
    else
      placeholder_image
    end
  end

  private

  def placeholder_image
    'placeholder_150.png'
  end
end
