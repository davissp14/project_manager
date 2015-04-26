class TagsController < ApplicationController

  def new
    @tag = Tag.new 
  end

  def index
    @tags = Tag.all
  end

  def edit

  end

  def create

  end
  
end
