# frozen string literal: true

class Api::V1::AuthenticationController < ApplicationController
  include JsonWebToken

  skip_before_action :authorize_request

  # POST /api/v1/auth/login
  def login
    @user = User.find_by_email!(params[:email])

    if @user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
