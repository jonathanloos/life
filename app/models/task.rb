class Task < ApplicationRecord
  belongs_to :task_list, optional: false

  validates :name, presence: true

  def complete?
    completed_at.present?
  end
end
