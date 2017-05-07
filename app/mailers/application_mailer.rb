class ApplicationMailer < ActionMailer::Base
  default from: 'account@savvspace.com'
  default template_path: 'mailers'

  layout 'mailer'

  protected

  def find_item_by(item_id, item_type)
    item_type.constantize.find(item_id)
  end
end
