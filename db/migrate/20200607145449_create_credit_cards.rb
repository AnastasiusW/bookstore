class CreateCreditCards < ActiveRecord::Migration[6.0]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :card_name
      t.string :cvv
      t.string :expiration_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
