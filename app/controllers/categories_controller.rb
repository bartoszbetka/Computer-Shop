class CategoriesController < ApplicationController
  before_action :confirm_logged_in, :except => [:index, :contact]
  before_action :privilege, :except => [:index, :contact]
  before_action :reset_session, :only => [:index, :contact]

  def index
    @categories = Category.visible
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category created and wait for accept.'
      redirect_to(:action => 'manage')
    else
      render("new")
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:notice]='Category updated successfully.'
      redirect_to(:action => 'manage')
    else
      render('edit')
    end
  end

  def contact
  end

  #def delete
  #  @category = Category.find(params[:id])
  # @category.destroy
  # flash[:notice] = "Category '#{category.name}' destroyed successfully."
  #end
  def destroy
    @category = Category.find(params[:id])
    @products = @category.products.sorted
    @category.destroy if @products.each do |product| product.update_attributes(:visible => false)
    end
    flash.now[:notice]= "Category  destroyed sucessfully. All products with this category is invisible now"
    @categories = Category.all
  end

  def manage
    @categories = Category.all
  end

  def accept
    @category = Category.find(params[:id])
    @category.update_attributes(:visible => true)
    if @category.visible.present?
      flash[:notice]='Category updated successfully.'
      redirect_to(:action => 'manage')
    end
  end

  private

  def category_params
    params.require(:category).permit(:name,:description,:image, :visible)
  end

end
