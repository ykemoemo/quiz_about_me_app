class CreateChallengers < ActiveRecord::Migration[6.0]
  def change
    create_table :challengers do |t|
      t.string :name, null: false
      t.integer :score, null: false

      t.timestamps
    end
  end
end
