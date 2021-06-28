class Spending < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :description, length: { minimum: 3 }, presence: true
  validates :amount, length: { minimum: 1 }, numericality: { only_integer: true }, presence: true
end
