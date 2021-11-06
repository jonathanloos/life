class TaskList < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user
  validates :user, presence: true
  
  before_destroy -> { Notification.where("params->'task_list' = ?", Noticed::Coder.dump(self).to_json).destroy_all }

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
