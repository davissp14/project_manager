class TagsController < ApplicationController

  def new
    @tag = current_project.tags.new
  end

  def index
    @tags = Tag.all
  end

  def edit

  end

  def create

  end
  
end
