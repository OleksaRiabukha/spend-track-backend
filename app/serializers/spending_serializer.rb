
class SpendingSerializer < BaseSerializer
  attributes :description, :amount, :category_id
  belongs_to :user
  belongs_to :category
end