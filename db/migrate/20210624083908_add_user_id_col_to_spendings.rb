class AddUserIdColToSpendings < ActiveRecord::Migration[6.1]
  def change
    add_reference :spendings, :user, foreign_key: true
  end
end
