class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  has_one :owner, class_name: "User", foreign_key: :owner_id, through: :listing
end
