class AssignmentNotifyMailer < ApplicationMailer
  def notify(user, service_request)
    @user = user
    @service_request = service_request
    mail(to: @user.email, subject: '指派通知信')
  end
end
