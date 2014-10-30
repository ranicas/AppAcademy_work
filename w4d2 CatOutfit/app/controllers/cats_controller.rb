class CatsController < ApplicationController
  before_action :verify_user_owns_cat, only: [:edit, :update]
  
  def index
    @cats = Cat.all
    render :index
  end
  
  def show
    @cat = Cat.find(params[:id])
    @requests = @cat.cat_rental_requests.sort_by &:start_date
    render :show
  end
  
  def create
    @user_id = current_user.id
    @cat = Cat.new(cat_params.merge({ user_id: @user_id }))
    
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end
  
  def update
    
    @cat = Cat.find(params[:id])
    
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  def index
    @cats = Cat.all
  end

  def new
    @cat = Cat.new
    render :new
  end
  
  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end
  
  private
  
  def cat_params
    cat_attrs = [:birth_date, :color, :name, :sex, :description]
    params.require(:cat).permit(*cat_attrs)
  end
  
  def verify_user_owns_cat
    unless Cat.find(params[:id]).user_id == current_user.id
      redirect_to cats_url 
    end
  end
  
end
