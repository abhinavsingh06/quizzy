class SessionController < ApplicationController

  def new
    render
  end

  def create
    user = User.find_by(email: params[:login][:email])
    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id.to_s
      render status: :ok, json: { notice: 'Successfully logged in!' }
    else 
      render status: :not_found, json: { errors: ['Incorrect credentials, try again.'] }
    end
  end
end
