class CreateChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :choices do |t|
      t.text :body, null: false
      t.boolean :correct_answer, null: false, default: false

      t.timestamps
    end
  end
end
