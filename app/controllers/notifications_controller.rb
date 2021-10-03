class NotificationsController < ApplicationController
    before_action :set_notification, only: [:destroy, :toggle_read]
    before_action :set_user, only: [:index]

    # GET /notifications
    # GET /notifications.json
    def index

        @notifications = if params[:filter] == "read"
            @user.notifications.newest_first.read
        elsif params[:filter] == "unread"
            @user.notifications.newest_first.unread
        else
            @user.notifications.newest_first
        end
    end

    # DELETE /notifications/1
    # DELETE /notifications/1.json
    def destroy
        @notification.destroy
        respond_to do |format|
            format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    def toggle_read
        @notification.mark_as_read!

        @user = @notification.recipient

        respond_to do |format|
            format.html { redirect_to @notification.to_notification.url }
            format.js { render 'notifications.js.erb' }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
        @notification = Notification.find(params[:id])
    end

    def set_user
        @user = User.find(params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def notification_params
        params.require(:notification).permit({})
    end
end
  