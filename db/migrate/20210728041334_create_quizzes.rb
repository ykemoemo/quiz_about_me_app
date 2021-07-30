class CreateQuizzes < ActiveRecord::Migration[6.0]
  def change
    create_table :quizzes do |t|
      t.string :creator_name, null: false

      t.timestamps
    end
  end
end
