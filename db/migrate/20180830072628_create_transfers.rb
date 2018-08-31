class CreateTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :transfers do |t|
      t.references :from_account, index: true, foreign_key: {to_table: :accounts}
      t.references :to_account, index: true, foreign_key: {to_table: :accounts}
      t.decimal :amount, :precision => 20, :scale => 10

      t.timestamps
    end
  end
end
