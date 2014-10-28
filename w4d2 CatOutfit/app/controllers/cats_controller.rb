class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end
  
  def show
    @cat = Cat.find(params[:id])
    render :show
  end
  
  def create
    p "THESE ARE THE PARAMS"
    p params
    p "THESE ARE THE CAT PARAMS"
    p params[:cat]
    
    @cat = Cat.new(cat_params)
    
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def index
    @cats = Cat.all
  end

  def new
    @cat = Cat.new
    render :new
  end
  
  private
  
  def cat_params
    cat_attrs = [:birth_date, :color, :name, :sex, :description]
    params.require(:cat).permit(*cat_attrs)
  end
  
end
