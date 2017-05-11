class ApplicationMailer < ActionMailer::Base
  default from: I18n.t('mailer.default_from')
  default template_path: 'mailers'

  layout 'mailer'

  protected

  def sending_away?(sender, receiver)
    sender.email != receiver
  end

  def subject_for(referrer, item_type, sending_away, mailer_type)
    if sending_away
      I18n.t("#{mailer_type}_mailer.subject.away", referrer_name: referrer.name, item_type: item_type.titleize)
    else
      I18n.t("#{mailer_type}_mailer.subject.to_self", item_type: item_type.titleize)
    end
  end

end
