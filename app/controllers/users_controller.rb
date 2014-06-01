class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy,:liked_movies]
  
  def index
    @users = User.all
    respond_to do |format|
      format.json {render :json => @users.to_json}
    end
  end

  def show  
    render :json => @user
  end
  def create
    @user = User.new(user_params)
    if @user.duplicate?
      render :json => "Email already exist!"
    else
      if @user.save
        render :json=> "true"
      else
        render :json=> "false"
      end
    end        
  end
  
  def update
    
    if @user.update(user_params)
      render :json=> "true"
    elsif @user.duplicate?
      render :json => "Email already exist!"
    else
      render :json=> "false"
    end
    
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.json {render :json=> "true"}
    end
  end

  def liked_movies
    render :json => @user.liked_movies.to_json(:methods => [:tag_list])
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
