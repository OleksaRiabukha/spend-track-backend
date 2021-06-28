class Category < ApplicationRecord
  has_many :spendings
  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
end
