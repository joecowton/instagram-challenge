class Picture < ApplicationRecord

  belongs_to :user
  has_many :comments
  acts_as_votable


  mount_uploader :image, ImageUploader
end
