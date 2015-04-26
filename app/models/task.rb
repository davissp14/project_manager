class Task < ActiveRecord::Base
  belongs_to :project
  has_many :tags
  has_many :comments

  before_save do
    self.status ||= 'feature'
  end

end
