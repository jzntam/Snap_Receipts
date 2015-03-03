class Report < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  has_many :receipts, -> { order "created_at DESC" }

end
