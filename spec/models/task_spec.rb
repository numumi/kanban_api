require 'rails_helper'

RSpec.describe Task do
  let!(:task) { create(:task) }
  let!(:column) { create(:column) }

  describe 'バリデーション' do
    it '有効なファクトリを持つこと' do
      expect(task).to be_valid
    end

    it '名前がある場合は有効であること' do
      task.name = 'テストタスク'
      expect(task).to be_valid
    end

    it '名前がない場合は無効であること' do
      task.name = nil
      expect(task).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    it 'TaskはColumnに属していること' do
      association = described_class.reflect_on_association(:column)
      expect(association.macro).to eq :belongs_to
    end
  end
end
