require 'rails_helper'

RSpec.describe Choice, type: :model do
  describe 'validation' do
    it '選択肢を入力したとき有効' do
      choice = build(:choice)
      expect(choice).to be_valid
      expect(choice.errors).to be_empty
    end

    it '選択肢が空のとき無効' do
      choice_without_body = build(:choice, body: "")
      expect(choice_without_body).to be_invalid
      expect(choice_without_body.errors[:body]).to eq ["を入力してください"]
    end

    it '選択肢が25文字以上のとき無効' do
      choice_word_count_body = build(:choice, body: "a" * 25)
      expect(choice_word_count_body).to be_invalid
      expect(choice_word_count_body.errors[:body]).to eq ["は24文字以内で入力してください"]
    end

    it '正解の回答がnilのとき無効' do
      choice_nil_correct_answer = build(:choice, correct_answer: nil)
      expect(choice_nil_correct_answer).to be_invalid
      expect(choice_nil_correct_answer.errors[:correct_answer]).to eq ["は一覧にありません"]
    end
  end
end
