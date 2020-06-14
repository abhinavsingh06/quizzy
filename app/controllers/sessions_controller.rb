class SessionsController < ApplicationController
  before_action :ensure_user_not_logged_in, only: [:new]
  
  def new
    render
  end

  def create
    user = User.find_by(email: params[:session][:email])
    respond_to do |format|
      if user&.role == "regular_user"
        format.json do
          render status: :unauthorized, json: { errors: ['Unauthorized user!'] }
        end
      elsif user&.authenticate(params[:session][:password])
        session[:user_id] = user.id.to_s
        format.html do
          flash[:success] = 'Successfully logged in!'
          redirect_to quizzes_path
        end   
        format.json do
          render status: :ok, json: { notice: 'Successfully logged in!' }
        end
      else
        format.html do
           flash[:danger] = 'Incorrect credentials, try again.'
           redirect_to new_sessions_path
        end    
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
      format.html do
        flash[:success] = 'Successfully logged out!'
        redirect_to root_path 
      end 
      format.json do
        render status: :ok, json: { notice: 'Successfully logged out!' }
      end
    end 
  end
end
