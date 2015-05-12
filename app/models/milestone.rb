class Milestone < ActiveRecord::Base
  has_many :tasks
  belongs_to :project 


  def to_param
    self.title
  end
  
end
