class OrderMailer < ApplicationMailer

  default from: 'noreply@api.com'

  def send_confirmation
    @order = order
    @user = @order.user
    mail to: @user.email, subject: "Order Confirmation"
  end
end
