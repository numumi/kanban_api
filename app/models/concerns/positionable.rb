module Positionable
  extend ActiveSupport::Concern

  class_methods do
    # 並び順採番共通メソッド
    def next_position(parent_id:, parent_attribute:)
      max_position = where(parent_attribute => parent_id).maximum(:position)
      max_position.nil? ? 0 : max_position.next
    end
  end
end