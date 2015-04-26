module TasksHelper

  def task_label_status(task)
    case task.status
    when 'finished'
      'success'
    when 'abandoned'
      'default'
    when 'active'
      'primary'
    when 'pending'
      'info'
    else
      'warning'
    end
  end

end
