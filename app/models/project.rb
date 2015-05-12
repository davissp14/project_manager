class Project < ActiveRecord::Base
  has_many :milestones
  has_many :tasks
  has_many :tags
  has_many :hackpads

  def to_param
    "#{name}"
  end

  def open_tasks
    self.tasks.size
  end

end
