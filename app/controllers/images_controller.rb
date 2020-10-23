class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    is_saved = @image.save
    if is_saved
      redirect_to @image
    else
      render 'new'
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  def index
    @images = Image.order('created_at desc')
  end

  def search
    @query = params[:id]
    @images = Image.tagged_with(@query)
  end

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end
end
