class Milestone < ActiveRecord::Base
  has_many :tasks
  belongs_to :project 

  validates :title, format: { with: /\A[a-zA-Z\s]+\z/,
    message: "only allows letters" }

  before_save do 
    self.slug = self.title.downcase.strip.gsub(/\s+/, '-') if new_record?
  end

  def to_param
    self.slug
  end
  
end
