class SessionsController < ApplicationController

    def new
        @user = User.new
        @users = User.all
    end

    def create
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            flash[:success] = "Successfully logged in!"
            redirect_to user_path(@user)
        else
            flash[:error] = "Couldn't find username and password"
            redirect_to login_path
        end
    end

    def destroy
        session.destroy
        redirect_to root_url
    end
end
