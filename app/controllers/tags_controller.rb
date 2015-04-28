class TagsController < ApplicationController

  def new
    @project = Project.find_by_name(params[:project_id])
    @tag = @project.tags.new
  end

  def index
    @project = Project.find_by_name(params[:project_id])
    @tags = Tag.all
  end

  def edit

  end

  def create

  end
  
end
