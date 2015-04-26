class Task < ActiveRecord::Base
  belongs_to :project
  has_many :tags
  has_many :comments

  AVAILABLE_STATUSES = %w(pending active finished abandoned)

  before_save do
    self.status ||= 'pending'
  end

end