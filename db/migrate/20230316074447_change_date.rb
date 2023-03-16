class ChangeDate < ActiveRecord::Migration[7.0]
  def change
    change_column(:bookings, :start_date, :date)
    change_column(:bookings, :end_date, :date)
  end
end
