class Task < ApplicationRecord
  belongs_to :task_list, optional: false
end
