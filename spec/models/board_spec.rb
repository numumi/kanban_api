require 'rails_helper'

RSpec.describe Board do
  let!(:board) { create(:board) }

  describe 'バリデーション' do
    before do
      board.image.attach(io: Rails.root.join('spec/fixtures/files/wood-texture_00003.jpg').open, filename: 'wood-texture_00003.jpg', content_type: 'image/jpeg')
    end

    it '有効なファクトリを持つこと' do
      expect(board).to be_valid
    end

    it '名前がある場合は有効であること' do
      board.name = 'テストボード'
      expect(board).to be_valid
    end

    it '名前がない場合は無効であること' do
      board.name = nil
      expect(board).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    before do
      board.image.attach(io: Rails.root.join('spec/fixtures/files/wood-texture_00003.jpg').open, filename: 'wood-texture_00003.jpg', content_type: 'image/jpeg')
    end

    it 'カラムとの関連付けができていること' do
      column = board.columns.build(name: 'テストカラム')
      expect(board.columns).to include(column)
    end

    it 'ボードが削除されると関連するカラムも削除されること' do
      expect { board.destroy }.to change(Column, :count).by(-3)
    end

    it '画像との関連付けができていること' do
      expect(board.image).to be_attached
      expect(board.image.filename.to_s).to eq('wood-texture_00003.jpg')
    end
  end
end
