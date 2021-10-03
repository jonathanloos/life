class Notification::ListComponent < ViewComponent::Base
  def initialize(notifications:)
    @notifications = notifications
  end
end
