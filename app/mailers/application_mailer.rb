class ApplicationMailer < ActionMailer::Base
  default from: 'account@savvspace.com'
  default template_path: 'mailers'
  default template_name: 'items'

  layout 'mailer'

  protected

  def find_item(item_id, item_type)
    item_type.constantize.find(item_id)
  end
end
