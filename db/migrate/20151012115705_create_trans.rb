class CreateTrans < ActiveRecord::Migration
  def change
    create_table :trans do |t|
      t.integer :stake
      t.float :winnings
      t.float :total_odds
      t.string :status
      t.references :account, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
