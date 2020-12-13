class Image < ApplicationRecord
  validates :img_path,presence: true
  has_many :resumes
end