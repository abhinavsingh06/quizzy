class SessionController < ApplicationController
  before_action :user_authenticated, only: [:new]
  
  def new
    render
  end

  def create
    user = User.find_by(email: params[:session][:email])
    respond_to do |format|
      if user&.authenticate(params[:session][:password])
        session[:user_id] = user.id.to_s
        format.html { redirect_to quizzes_path }
        format.json do
          render status: :ok, json: { notice: 'Successfully logged in!' }
        end
      else
        format.html { redirect_to new_session_path }
        format.json do
          render status: :not_found, json: { errors: ['Incorrect credentials, try again.'] }
        end 
      end
    end
  end

  def destroy
    session.delete(:user_id)
    current_user = nil
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json do
        render status: :ok, json: { notice: 'Successfully logged out!' }
      end
    end 
  end
end
