class ApplicationMailer < ActionMailer::Base
  default from: 'account@savvspace.com'
  default template_path: 'mailers'

  layout 'mailer'

end
