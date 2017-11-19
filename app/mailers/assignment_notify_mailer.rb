class AssignmentNotifyMailer < ApplicationMailer
  def notify(user, service_request)
    @user = user
    @service_request = service_request
    mail(to: @user.email, subject: '指派通知信')
  end

  def notify_customer(customer, service_request)
    @customer = customer
    @service_request = service_request
    mail(to: @customer.email, subject: 'EF Claim Service System - New Claim Created')
  end

  def reply_notify_customer(customer, service_request)
    @customer = customer
    @service_request = service_request
    mail(to: @customer.email, subject: 'EF Claim Service System - New Reply Coming')
  end

  def change_state(user, service_request)
    @user = user
    @service_request = service_request
    mail(to: @user.email, subject: 'EF Claim Service System - Change State')
  end
end
