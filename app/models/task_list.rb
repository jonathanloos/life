class TaskList < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  enum do_date: {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6
}, _prefix: true

  def incomplete_tasks
    tasks.where(completed_at: nil)
  end
end
