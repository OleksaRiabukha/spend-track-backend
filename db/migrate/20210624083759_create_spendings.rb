class CreateSpendings < ActiveRecord::Migration[6.1]
  def change
    create_table :spendings do |t|
      t.string :description
      t.integer :amount

      t.timestamps
    end
  end
end
