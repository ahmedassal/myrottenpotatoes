class MoviesController < ApplicationController

  before_filter :check_for_create_cancel, :only => [:create]
  before_filter :check_for_update_cancel, :only => [:update]
  def index
    @movies = Movie.order("title").all
    @movies = @movies.sort_by { |movie| movie.title}
  end

  def show
    id = params[:id]
    @movie = Movie.find_by_id(id)
  end

  def new

  end

  def create
    #debugger
    @movie = Movie.new(movie_params)
    if (@movie.save)
      flash[:notice] = "#{@movie.title} was successfully created."
      flash[:color]= "valid"
    else
      flash[:notice] = "#{@movie.title} was not created!"
      flash[:color]= "invalid"
    end
    redirect_to movie_path(@movie)
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    #@movie.update_attributes!(params[:movie])
    @movie.update_attributes!(movie_params)


    #if (@movie.save)
      flash[:notice] = "#{@movie.title} was successfully updated."
      flash[:color]= "valid"
    # else
    #   flash[:notice] = "#{@movie.title} was not updated!"
    #   flash[:color]= "invalid"
    # end
    redirect_to movies_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie #{@movie.title} was successfully deleted."
    flash[:color]= "valid"
    redirect_to movies_path

  end

  private
  def movie_params
    params.require(:movie).permit(:title, :rating, :release_date)
  end

  def check_for_create_cancel
    if(params.key?("cancel"))
      flash[:notice] = "Operation cancelled!"
      flash[:color]= "invalid"
      redirect_to movies_path
    end
  end

  def check_for_update_cancel
    if(params.key?("cancel"))
      flash[:notice] = "Operation cancelled!"
      flash[:color]= "invalid"
      redirect_to movie_path(params[:movie])
    end
  end
end

