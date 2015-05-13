class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  has_many :tasks
  has_many :owned_tasks, class_name: 'Task', foreign_key: :owner_id, primary_key: :id
  has_many :projects

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def slug
    self.email.split('@').first
  end
end
