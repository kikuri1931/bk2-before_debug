class Batch::SendMail
  def self.send_mail
    DailyMailer.confirmation.deliver_now
     p "メール送信しました"
  end
end
