class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  field :position, type: Integer

  embedded_in :column
end
