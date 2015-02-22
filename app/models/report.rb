class Report < ActiveRecord::Base
  validates :title, presence: true

  has_many :receipts
end
