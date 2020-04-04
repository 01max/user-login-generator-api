# frozen_string_literal: true

class UsersController < ApplicationController
  # POST /users.json
  def create
    if params[:login].present?
      @user = User.new(login: params['login'])

      if @user.save
        render json: { message: 'OK', submitted_login: params['login'], created_user: @user }
      else
        render alternative_login_creation
      end
    else
      render json: { message: 'A login must be submitted' }, status: :unprocessable_entity
    end
  end

  private

  def alternative_login_creation
    if @user.save_with_alternative_login
      { json: { message: @user.login, submitted_login: params['login'], created_user: @user } }
    else
      {
        json: { message: @user&.errors&.messages&.join("\n"), user: @user },
        status: :unprocessable_entity
      }
    end
  end
end
