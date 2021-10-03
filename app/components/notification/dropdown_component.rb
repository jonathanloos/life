class Notification::DropdownComponent < ViewComponent::Base
    def initialize(notifications:)
        @notifications = notifications
    end
end