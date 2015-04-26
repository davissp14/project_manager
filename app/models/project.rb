class Project < ActiveRecord::Base
  has_many :tasks

  def to_param
    "#{name}"
  end

  def open_tasks
    self.tasks.size
  end

end
