class WebhooksController < ActionController::Base
  def line
    @line_user_id = params[:events][0][:source][:userId]
    @text = params[:events][0][:message][:text]

    verify_user(text)

    render text: '202'
  end

  private

  def verify_user
    if (@text =~ /!驗證 /) == 0 || (@text =~ /！驗證 /) == 0
      parse_text(@text)
      user = User.find_by_email(@email)
      if user
        if user.valid_password?(@password)
          user.update(line_user_id: @line_user_id)
          LineService.send(user.line_user_id, "Hi #{user.username}, 已經把您的Line帳號與EFeng帳號進行連結，歡迎使用。")
        else
          LineService.send(@line_user_id, "不好意思，密碼錯誤。")  
        end
      else
        LineService.send(@line_user_id, "不好意思，找不到這個電子信箱喔，請確定您已經在EFeng客訴系統註冊了。 #{@email}")
      end
    end
  end

  def parse_text(text)
    @email = /\!驗證 (.*):/.match(text).to_s
    @email.slice!('!驗證 ')
    @email.slice!(':')
    @password = /:.*/.match(text).to_s
    @password.slice!(':')
  end

end
