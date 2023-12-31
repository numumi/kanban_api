require 'rails_helper'

RSpec.describe Column do

  let!(:column) { create(:column) }

  describe 'バリデーション' do
    it '有効なファクトリを持つこと' do
      expect(column).to be_valid
    end

    it '名前がある場合は有効であること' do
      column.name = 'テストボード'
      expect(column).to be_valid
    end

    it '名前がない場合は無効であること' do
      column.name = nil
      expect(column).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    it 'タスクとの関連付けができていること' do
      task = column.tasks.build(name: 'テストタスク')
      expect(column.tasks).to include(task)
    end

    it 'ボードが削除されると関連するカラムも削除されること' do
      expect { column.destroy }.to change(Task, :count).by(-3)
    end
  end
end
