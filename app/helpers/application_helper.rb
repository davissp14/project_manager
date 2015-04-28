module ApplicationHelper

  def sub_nav(&block)
    render 'shared/sub_nav', block: block
  end

  def current_controller(controller)
    params[:controller] == controller
  end

end
