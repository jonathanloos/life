class User < ApplicationRecord
    has_many :events, dependent: :destroy
    has_many :task_lists, dependent: :destroy
    has_many :tasks, dependent: :destroy

    # Notifications
    has_many :notifications, as: :recipient
    
    def name
        first_name + ' ' + last_name
    end
end
