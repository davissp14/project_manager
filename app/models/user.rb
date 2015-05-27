class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  belongs_to :account
  has_many :tasks
  has_many :projects
  has_many :owned_tasks, class_name: 'Task', foreign_key: :owner_id, primary_key: :id

  accepts_nested_attributes_for :account

  before_save do 
    self.profile_icon = self.gravatar_url
    self.slug = self.email.split('@').first
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
