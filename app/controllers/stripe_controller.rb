class StripeController < ApplicationController
  before_action :authenticate_user!

  def create_customer
    redirect_url = if params[:intent_class] == 'FeatureRequest'
                     current_user.feature_requests.find(params[:intent_id])
                   end

    current_user.update(stripe_customer_id: customer_id_for_request)
    redirect_to redirect_url
  end

  private

  def customer_id_for_request
    if Rails.env.test?
      params[:stripe_token] == 'valid' ? SecureRandom.hex(16) : nil
    else
      Stripe::Customer.create(email: current_user.email, source: params[:stripe_token]).id
    end
  end
end
