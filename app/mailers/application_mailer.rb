class ApplicationMailer < ActionMailer::Base
  default from: I18n.t('mailer.default_from')
  default template_path: 'mailers'

  layout 'mailer'

  protected

  def sending_away?(sender, receiver)
    sender.email != receiver
  end

end
