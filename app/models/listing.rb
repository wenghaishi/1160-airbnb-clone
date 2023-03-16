class Listing < ApplicationRecord
  has_many :bookings
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  has_many_attached :photos
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
