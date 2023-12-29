boards = [
  {
    image_path: "public/images/wood-texture_00003.jpg",
    name: "Board 1",
    columns: [
      {
        name: "To Do",
        tasks: [
          {
            name: "発注書",
            description: "発注書詳細"
          },
          {
            name: "検討中",
            description: "検討中詳細"
          },
          {
            name: "見積もり",
            description: "見積もり詳細"
          }
        ]
      },
      {
        name: "In Progress",
        tasks: [
          {
            name: "進捗報告",
            description: "進捗報告詳細"
          },
          {
            name: "調査中",
            description: "調査中詳細"
          }
        ]
      },
      {
        name: "Done",
        tasks: [
          {
            name: "納品完了",
            description: "納品完了詳細"
          },
          {
            name: "修正対応",
            description: "修正対応詳細"
          }
        ]
      }
    ]
  },
  {
    image_path: "public/images/texture_00065.jpg",
    name: "Board 2",
    columns: [
      {
        name: "To Do",
        tasks: [
          {
            name: "仕様検討",
            description: "仕様検討詳細"
          },
          {
            name: "見積もり",
            description: "見積もり詳細"
          },
          {
            name: "発注書",
            description: "発注書詳細"
          }
        ]
      },
      {
        name: "In Progress",
        tasks: [
          {
            name: "開発中",
            description: "開発中詳細"
          },
          {
            name: "テスト中",
            description: "テスト中詳細"
          }
        ]
      },
      {
        name: "Done",
        tasks: [
          {
            name: "リリース",
            description: "リリース詳細"
          },
          {
            name: "修正対応",
            description: "修正対応詳細"
          }
        ]
      }
    ]
  },
  {
    image_path: "public/images/mountain_00004.jpg",
    name: "Board 3",
    columns: [
      {
        name: "To Do",
        tasks: [
          {
            name: "検討中",
            description: "検討中詳細"
          },
          {
            name: "見積もり",
            description: "見積もり詳細"
          },
          {
            name: "発注書",
            description: "発注書詳細"
          }
        ]
      },
      {
        name: "In Progress",
        tasks: [
          {
            name: "開発中",
            description: "開発中詳細"
          },
          {
            name: "テスト中",
            description: "テスト中詳細"
          }
        ]
      },
      {
        name: "Done",
        tasks: [
          {
            name: "リリース",
            description: "リリース詳細"
          },
          {
            name: "修正対応",
            description: "修正対応詳細"
          }
        ]
      }
    ]
  }
]
p "Create Boards"
boards.each do |board|
  created_board = Board.create(name: board[:name])
  created_board.image.attach(io: File.open(Rails.root.join(board[:image_path])), filename: File.basename(board[:image_path]), content_type: 'image/jpg')

  board[:columns].each_with_index do |column, index|
    created_column = Column.create(name: column[:name], position: index, board_id: created_board.id)
    column[:tasks].each_with_index do |task, index|
      created_column.tasks.create(name: task[:name], description: task[:description], position: index)
    end
  end
end
p "Create Boards Done"
