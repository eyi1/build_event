class UsersController < ApplicationController
    #before_action :find_user, only: [:show]

    def show
        authenticate_user
        find_user
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user), notice: "Welcome to Event Builder- click create event to get started!"
        else
            render :new
        end
    end

    private

    def find_user
        @user = User.find_by(params[:id])
    end

    def user_params
        params.require(:user).permit(
            :name,
            :username,
            :email,
            :password_digest
        )
    end

end