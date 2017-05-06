class ApplicationMailer < ActionMailer::Base
  default from: 'account@savvspace.com'
  default template_path: 'mailers'
  default template_name: 'items'

  layout 'mailer'
end
