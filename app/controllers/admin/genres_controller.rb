class Admin::GenresController < Admin::BaseController
  def index
    @genres = Genre.order(created_at: :desc)
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      redirect_to admin_genres_path, notice: "ジャンルを追加しました"
    else
      @genres = Genre.order(created_at: :desc)
      flash.now[:alert] = "ジャンル名を入力してください"
      render :index, status: :unprocessable_entity
    end
  end

  def update
    genre = Genre.find(params[:id])

    if genre.update(genre_params)
      redirect_to admin_genres_path, notice: "ジャンルを更新しました"
    else
      @genres = Genre.order(created_at: :desc)
      @genre = Genre.new
      flash.now[:alert] = "ジャンル名を入力してください"
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to admin_genres_path, notice: "ジャンルを削除しました"
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end