require 'rails_helper'

RSpec.describe Challenger, type: :model do
  describe 'validation' do
    it 'ニックネームを入力したとき有効' do
      challenger = build(:challenger)
      expect(challenger).to be_valid
      expect(challenger.errors).to be_empty
    end

    it 'ニックネームが空のとき無効' do
      challenger_without_name = build(:challenger, name: '')
      expect(challenger_without_name).to be_invalid
      expect(challenger_without_name.errors[:name]).to eq ['を入力してください']
    end

    it 'ニックネームが13文字以上のとき無効' do
      challenger_word_count_name = build(:challenger, name: 'a' * 13)
      expect(challenger_word_count_name).to be_invalid
      expect(challenger_word_count_name.errors[:name]).to eq ['は12文字以内で入力してください']
    end

    it 'スコアが数値でないとき無効' do
      challenger_nil_score = build(:challenger, score: 'score')
      expect(challenger_nil_score).to be_invalid
      expect(challenger_nil_score.errors[:score]).to eq ['は数値で入力してください']
    end
  end
end
