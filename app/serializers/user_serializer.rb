
class UserSerializer < BaseSerializer
  attributes :id, :first_name, :last_name, :email
  has_many :spendings
end