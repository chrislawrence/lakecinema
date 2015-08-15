class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update(page_params)
      redirect_to admin_path
      flash[:notice] = "#{@page.title} page was updated"
    else
      flash[:alert] = "The page could not be saved"
      render action: :edit
    end
  end

  def page_params
    params.require(:page).permit(:content)
  end
end
