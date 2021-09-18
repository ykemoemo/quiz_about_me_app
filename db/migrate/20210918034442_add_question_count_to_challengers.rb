class AddQuestionCountToChallengers < ActiveRecord::Migration[6.0]
  def change
    add_column :challengers, :question_count, :integer, null: false, default: false
  end
end
