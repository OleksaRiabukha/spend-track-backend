class Spending < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :description,
            :amount,
            presence: true
end
