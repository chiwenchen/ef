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

  def notify_staff(staff, service_request)
    @staff = staff
    @service_request = service_request
    mail(to: @staff.email, subject: '易鋒客訴系統 - 新客訴單開立通知')
  end

  def reply_notify_customer(customer, service_request)
    @customer = customer
    @service_request = service_request
    mail(to: @customer.email, subject: 'EF Claim Service System - New Reply Coming')
  end

  def reply_notify_staff(staff, service_request)
    @staff = staff
    @service_request = service_request
    mail(to: @staff.email, subject: '易鋒客訴系統 - 有新的回覆')
  end

  def notify_customer_state_change(user, service_request)
    @user = user
    @service_request = service_request
    mail(to: @user.email, subject: 'EF Claim Service System - Change State')
  end

  def notify_staff_state_change(user, service_request)
    @user = user
    @service_request = service_request
    mail(to: @user.email, subject: '易鋒客訴系統 - 客訴單狀態變更通知')
  end
end
