module TasksHelper

  def task_label_status(task)
    case task.status
    when 'complete'
      'success'
    when 'abandoned'
      'default'
    when 'open'
      'primary'
    when 'pending'
      'info'
    else
      'warning'
    end
  end

end
