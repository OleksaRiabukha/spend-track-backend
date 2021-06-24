class AddSpendingIdColToCategories < ActiveRecord::Migration[6.1]
  def change
    add_reference :categories, :spending, foreign_key: true
  end
end
