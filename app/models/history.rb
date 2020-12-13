class History < ApplicationRecord
  validates :image_id,presence: true
  validates :pred_label,presence: true
  belongs_to :image
end