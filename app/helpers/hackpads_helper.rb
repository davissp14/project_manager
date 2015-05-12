module HackpadsHelper

  def archived_hackpads
    current_project.hackpads.where(status: 'archived')
  end

  def active_hackpads
    current_project.hackpads.where(status: 'active')
  end
end
