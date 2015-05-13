module MilestonesHelper

  def percentage_complete(milestone)
    closed = milestone_closed_tasks(milestone).to_f
    open = milestone_open_tasks(milestone).to_f
    
    return 0 if open == 0 && closed == 0
    
    ((closed / (closed + open)) * 100).round(0)
  end

  def milestone_open_tasks(milestone)
    milestone.tasks.select{|task| task.status == 'open' }.size
  end

  def milestone_closed_tasks(milestone)
    milestone.tasks.select{|task| task.status == 'closed' }.size
  end

end
