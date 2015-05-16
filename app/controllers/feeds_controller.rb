class FeedsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @feeds = []
  end
end
