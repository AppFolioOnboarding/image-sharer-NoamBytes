class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(url: params[:image][:url])
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
    @images = Image.order("created_at desc")
  end
end
