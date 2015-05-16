class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :owner, class_name: "User", foreign_key: :owner_id, primary_key: :id
  belongs_to :project
  
  has_many :tags
  has_many :comments

  AVAILABLE_STATUSES = %w(open active closed)

  before_save do
    self.status ||= 'open'
  end

  def priority_label
    case self.priority_status 
    when 3
      "High"
    when 2
    else
      "Low"
    end
  end

end
