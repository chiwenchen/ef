class Admin::CategoriesController < AdminController

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @categories = Category.all
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = t('add_category_success')
      redirect_to :back
    else
      flash[:notice] = @category.errors.full_messages
      render :index
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = t('delete_category_success')
    redirect_to :back
  end

  private

  def category_params
    params.require(:category).permit(:tw_title, :en_title, :note)
  end
end