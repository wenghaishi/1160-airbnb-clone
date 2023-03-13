class Listing < ApplicationRecord
  has_many :bookings
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
end
