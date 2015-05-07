module TasksHelper

  def task_label_status(task)
    case task.status
    when 'open'
      'success'
    when 'closed'
      'danger'
    else
      'warning'
    end
  end

  def highlight_icon?(size)
    size > 0 ? 'icon_active' : ''
  end

  def closed_tasks
    current_project.tasks.select{|task| task.status == 'closed' }
  end

  def open_tasks
    current_project.tasks.select{|task| task.status == 'open' }
  end

end
