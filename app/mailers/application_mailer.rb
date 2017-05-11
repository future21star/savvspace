class ApplicationMailer < ActionMailer::Base
  default from: I18n.t('mailer.default_from')
  default template_path: 'mailers'

  layout 'mailer'

end
