# To deliver this notification:
#
# TaskListCreatedNotification.with(post: @post).deliver_later(current_user)
# TaskListCreatedNotification.with(post: @post).deliver(current_user)

class TaskListCreatedNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :task_list

  # Define helper methods to make rendering easier.
  #
  def message
    "Task list created: #{params[:task_list].name}"
  end

  def url
    task_lists_path
  end
end
