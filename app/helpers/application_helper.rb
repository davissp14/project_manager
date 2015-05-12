module ApplicationHelper

  def sub_nav(&block)
    render 'shared/sub_nav', block: block
  end

  def current_controller(controller)
    params[:controller] == controller
  end

  def form_footer(&block)
    content_tag(:div, class: 'footer') do 
      concat(content_tag(:div, capture(&block), class: 'pull-right'))
      concat(content_tag(:div, nil, class: 'clearfix'))
    end
  end
end
