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

  def task_priority_status(task)
    case task.priority_status
    when 3
      'danger'
    when 1
      'primary'
    else
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

  def task_owner?(task)
    task.user.id == current_user.id
  end

end
