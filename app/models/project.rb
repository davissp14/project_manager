class Project < ActiveRecord::Base
  belongs_to :account
  has_many :kanbans
  has_many :tasks
  has_many :tags
  has_many :hackpads

  validates :name, format: { with: /\A[a-zA-Z\s]+\z/,
    message: "only allows letters" }

  before_save do 
    self.slug = self.name.downcase.strip.gsub(/\s+/, '-') if new_record?
  end

  def to_param
    slug
  end

  def open_tasks
    self.tasks.size
  end

end
