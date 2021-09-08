require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validation' do
    it '質問を入力したとき有効' do
      question = build(:question)
      expect(question).to be_valid
      expect(question.errors).to be_empty
    end

    it '質問が空のとき無効' do
      question_without_body = build(:question, body: "")
      expect(question_without_body).to be_invalid
      expect(question_without_body.errors[:body]).to eq ["を入力してください"]
    end

    it '質問が23文字以上のとき無効' do
      question_word_count_body = build(:question, body: "a" * 23)
      expect(question_word_count_body).to be_invalid
      expect(question_word_count_body.errors[:body]).to eq ["は22文字以内で入力してください"]
    end
  end
end
