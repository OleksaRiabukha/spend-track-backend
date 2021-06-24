class Spending < ApplicationRecord
  belongs_to :user
  validates :description,
            :amount,
            presence: true
end
