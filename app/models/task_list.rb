class TaskList < ApplicationRecord
  has_many :tasks
  belongs_to :user

  def incomplete_tasks
    tasks.where(completed_at: nil)
  end
end
