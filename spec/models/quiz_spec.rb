require 'rails_helper'

RSpec.describe Quiz, type: :model do
  describe 'validation' do
    it 'ニックネームを入力したとき有効' do
      quiz = build(:quiz)
      expect(quiz).to be_valid
      expect(quiz.errors).to be_empty
    end

    it 'ニックネームが空のとき無効' do
      quiz_without_creator_name = build(:quiz, creator_name: '')
      expect(quiz_without_creator_name).to be_invalid
      expect(quiz_without_creator_name.errors[:creator_name]).to eq ['を入力してください']
    end

    it 'ニックネームが13文字以上の時無効' do
      quiz_word_count_creator_name = build(:quiz, creator_name: 'a' * 13)
      expect(quiz_word_count_creator_name).to be_invalid
      expect(quiz_word_count_creator_name.errors[:creator_name]).to eq ['は12文字以内で入力してください']
    end
  end
end
