class Task < ApplicationRecord
  belongs_to :task_list, optional: false

  validates :name, presence: true
end
