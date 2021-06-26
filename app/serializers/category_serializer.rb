
class CategorySerializer < BaseSerializer
  attributes :name
  has_many :spendings
end