class HackpadsController < ApplicationController

  def index 
    if params.has_key?(:status)
      @hackpads = current_project.hackpads.where(status: params[:status])
    else
      params[:status] = 'active'
      @hackpads = current_project.hackpads.where(status: 'active')
    end
  end

  def show 
    @hackpad = current_project.hackpads.find(params[:id])
    add_breadcrumb "<strong>#{@hackpad.title}</strong>".html_safe
  end

  def new
    @hackpad = current_project.hackpads.new 
  end

  def create
    hackpad = current_project.hackpads.new(hackpads_params)
    hackpad.save! && hackpad.persist!

    redirect_to project_hackpads_path(current_project)
  end

  def resync 
    Hackpad.resync(current_project)
    redirect_to project_hackpads_path(current_project)
  end

  private

  def hackpads_params
    params.require(:hackpad).permit(:title)
  end

end
