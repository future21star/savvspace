class IvrController < ApplicationController
  layout 'ivr'

  def click_to_call
    @phone_call = PhoneCall.find_by!(sid: params['CallSid'])
  end
end
