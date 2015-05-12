class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :milestone
  has_many :tags
  has_many :comments

  AVAILABLE_STATUSES = %w(open active closed)

  before_save do
    self.status ||= 'open'
  end

end
