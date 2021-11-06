class PushNotificationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "push_notification_channel"
    stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def self.wire(current_user, data)
    self.broadcast_to(
      current_user, 
      body: { 
        html: html(data),
        variables: {
          text: data[:text]
        }
      }
    )
  end

  def self.html(data)
    ApplicationController.render(
      partial: 'task_lists/task_list_index',
      locals: { user: data[:user], task_lists: data[:task_lists] }
    )
  end
end
