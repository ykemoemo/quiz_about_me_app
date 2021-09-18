class AddSelectAnswerToChoices < ActiveRecord::Migration[6.0]
  def change
    add_column :choices, :select_answer, :boolean, null: false, default: false
  end
end
