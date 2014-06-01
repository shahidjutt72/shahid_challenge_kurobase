class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy,:like,:unlike,:liked_users]
  before_action :find_user, only: [:like,:unlike]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
    respond_to do |format|
      format.json {render :json => @movies.to_json(:methods => [:tag_list])}
    end
  end

  def show  
    render :json => @movie.to_json(:methods => [:tag_list])
  end
  
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.json {render :json=> "true"}
      else
        format.json {render :json=> "false"}
      end  
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.json {render :json=> "true"}
      else
        format.json {render :json=> "false"}
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.json {render :json=> "true"}
    end
  end

  def like    
    if @user
      if @movie.liked_users.exists? @user
        render :json =>"User already liked."
      else
        @movie.liked_users << @user
        render :json => "true" 
      end  
    else
      render :json =>"User not found."
    end      
  end
  
  def unlike
    if @user      
      @movie.liked_users.delete(@user)
      render :json => "true" 
      
    else
      render :json =>"User not found."
    end
  end

  def liked_users
    render :json => @movie.liked_users.to_json
  end  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end
    def find_user
      @user = User.find_by_id(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :year,:tag_list)
    end
end
