class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :tasks, dependent: :destroy
    has_many :events, dependent: :destroy
    has_many :task_lists, dependent: :destroy

    # Notifications
    has_many :notifications, as: :recipient
    
    def name
        first_name + ' ' + last_name
    end
end
