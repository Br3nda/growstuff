class Square < ActiveRecord::Base
  belongs_to :garden
  belongs_to :planting
end
