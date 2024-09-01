class User::GenresController < ApplicationController
  # 試験用（後でadminへ移行）
  def new
    @genre = Genre.new
  end


# 試験用（後でadminへ移行）
  def create
    @genre = Genre.new(genre_params)
    
    if @genre.save
      redirect_to genres_path
    else
      render :new
    end
  end

  def index
    @genres = Genre.all
  end


# 試験用（後でadminへ移行）
  def edit
    @genre = Genre.find(params[:id])
  end

# 試験用（後でadminへ移行）
  def update
    @genre = Genre.find(params[:id])
    
    if @genre.update(genre_params)
      redirect_to genres_path
    else
      render :edit
    end
  end

# 試験用（後でadminへ移行）
  def destroy
    @genre = Genre.find(params[:id])
    
    if @genre.destroy
      redirect_to genres_path
    else
      redirect_to genres_path
    end
  end
  
  
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
  
end
